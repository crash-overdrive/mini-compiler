import sys

class merl_file:
	def __init__(self, fname, read_type):
		self.length = 0
		self.clen = 0
		self.content = []
		self.code = []
		self.ESR = []
		self.ESD = []
		self.RE = []
		self.fname = fname
		if read_type == "xxd":
			with open(fname) as f:
				f = f.readlines()
				self.content = ["".join(line.split(" ")[1:3]) for line in f]
		

		self.get_header()
		self.clear_header()
		self.get_code()
		self.clear_code()
		self.get_REST()
		self.clear_REST()

	def get_header(self):
		self.length = self.content[1]
		self.clen = self.content[2]

	def clear_header(self):
		self.content = self.content[3:]

	def get_code(self):
		self.code = [ self.content[line] for line in range(int(self.clen,16)/4-3) ] 

	def clear_code(self):
		self.content = self.content[int(self.clen,16)/4-3:]

	def get_REST(self):
		entry = []
		i = 0
		while i < len(self.content):
			if self.content[i] == "00000011": #ESR
				entry.append("00000011")
				i += 1
				entry.append(self.content[i]) #location where symbol is used
				i += 1
				entry.append(self.content[i]) 
				word_len = int(self.content[i],16) # length of symbol in bytes
				for l in range(word_len):
					i += 1
					entry.append(self.content[i])
				self.ESR.append(entry)
				entry = []
			elif self.content[i] == "00000005": #ESD
				entry.append("00000005")
				i += 1
				entry.append(self.content[i])
				i += 1
				entry.append(self.content[i])
				word_len = int(self.content[i],16)
				for l in range(word_len):
					i += 1
					entry.append(self.content[i])
				self.ESD.append(entry)
				entry = []
			elif self.content[i] == "00000001": #RE
				entry.append("00000001")
				i += 1
				entry.append(self.content[i])
				self.RE.append(entry)
				entry = []
			else:
				raise Exception("Missing REST entry")
			i += 1

	def clear_REST(self):
		self.content = []

	def status(self):
		print("Status for " + self.fname)
		print "length:", int(self.length,16), self.length
		print "code length:", int(self.clen,16), self.clen
		print "ESD" 
		for e in self.ESD:
			print e
		print "ESR"
		for e in self.ESR:
			print e
		print "RE"
		for e in self.RE:
			print e

class link_merl:
	def __init__(self, m1, m2):
		self.m1 = m1
		self.m2 = m2
		self.alpha = int(self.m1.clen,16) - 12
		self.length = 0
		self.clen = 0
		self.code = []
		self.output = []
		self.content = []
		self.fix_RE()
		self.fix_REST()
		self.check_ESD_conflicts()
		self.copy_code()
		self.resolve_ESR()
		self.copy_REST()
		self.create_header()
		self.create_content()
		self.fix_content()

	def fix_RE(self):
		for entry in self.m2.RE:
			word_at = (int(entry[1],16)-12)/4
			self.m2.code[word_at] = hex(int(self.m2.code[word_at],16)+self.alpha)

	def fix_REST(self):
		for i, entry in enumerate(self.m2.RE):
			self.m2.RE[i][1] = hex(int(entry[1],16)+self.alpha)
		for i, entry in enumerate(self.m2.ESD):
			self.m2.ESD[i][1] = hex(int(entry[1],16)+self.alpha)
		for i, entry in enumerate(self.m2.ESR):
			self.m2.ESR[i][1] = hex(int(entry[1],16)+self.alpha)

	def check_ESD_conflicts(self):
		#print ("esd_i in: "  + self.m1.fname)
		#print ("esd_j in: "  + self.m2.fname)
		for esd_i in self.m1.ESD:
			esd_i_label = ""
			for n in range(int(esd_i[2],16)):
				esd_i_label += esd_i[3+n]
			#print ("esd_i_label : " + esd_i_label)
			for esd_j in self.m2.ESD:
				esd_j_label = ""

				#print("Loop gonna run " )
				#print(range(int(esd_j[2],16)))
				for n in range(int(esd_j[2],16)): 
					#print("Value of loop counter: ", n)
					esd_j_label += esd_j[3+n]
					#print(esd_j_label)
				if esd_i_label == esd_j_label:
					raise Exception("Multiply defined label")

	def copy_code(self):
		self.code = self.m1.code + self.m2.code

	def resolve_ESR(self):
		remove_from_m1_ESR = []
		for i, esr in enumerate(self.m1.ESR):
			esr_i_label = ""
			for n in range(int(esr[2],16)):
				esr_i_label += esr[3+n]
			for j, esd in enumerate(self.m2.ESD):
				esd_j_label = ""
				for n in range(int(esd[2],16)):
					esd_j_label += esd[3+n]

				if esr_i_label == esd_j_label:
					remove_from_m1_ESR.append(esr)
					word_at = int(esr[1],16)/4
					self.code[word_at] = esd[1]

		new_m1_ESR = []
		for e in self.m1.ESR:
			if e not in remove_from_m1_ESR:
				new_m1_ESR.append(e)

		for e in remove_from_m1_ESR:
			self.m1.RE.append([hex(1),e[1]])

		self.m1.ESR = new_m1_ESR

		remove_from_m2_ESR = []
		for i, esr in enumerate(self.m2.ESR):
			esr_i_label = ""
			for n in range(int(esr[2],16)):
				esr_i_label += esr[3+n]
			for j, esd in enumerate(self.m1.ESD):
				esd_j_label = ""
				for n in range(int(esd[2],16)):
					esd_j_label += esd[3+n]

				if esr_i_label == esd_j_label:
					remove_from_m2_ESR.append(esr)
					word_at = int(esr[1],16)/4 - 3
					self.code[word_at] = esd[1]

		new_m2_ESR = []
		for e in self.m2.ESR:
			if e not in remove_from_m2_ESR:
				new_m2_ESR.append(e)

		for e in remove_from_m2_ESR:
			self.m2.RE.append([hex(1),e[1]])
		
		self.m2.ESR = new_m2_ESR

	def copy_REST(self):
		self.ESR = self.m1.ESR + self.m2.ESR
		self.ESD = self.m1.ESD + self.m2.ESD
		self.RE = self.m1.RE + self.m2.RE

	def create_header(self):
		self.length = 3 + len(self.code)
		for e in self.ESD:
			self.length += 1
		for e in self.ESR:
			self.length += 1
		for e in self.RE:
			self.length += 1
		self.length = hex( self.length * 4 )
		self.clen = 3 + len(self.code)
		self.clen = hex( self.clen * 4 )

	def create_content(self):
		self.content.append("10000002")
		self.content.append("hold")
		self.content.append(self.clen)
		self.content += self.code
		for e in self.ESD:
			for l in e:
				self.content.append(l)
		for e in self.ESR:
			for l in e:
				self.content.append(l)
		for e in self.RE:
			for l in e:
				self.content.append(l)
		self.content[1] = hex(len(self.content * 4))

	def fix_content(self):
		for i, e in enumerate(self.content):
			self.content[i] = ".word 0x%08X" % (int(e,16))

	def status(self):
		print "length:", int(self.length,16), self.length
		print "code length:", int(self.clen,16), self.clen
		print "ESD"
		for e in self.ESD:
			print e
		print "ESR"
		for e in self.ESR:
			print e
		print "RE"
		for e in self.RE:
			print e

	def content_status(self):
		for e in self.content:
			print e



def main():
	if sys.argv[1].split(".")[-1] != "xxd" or sys.argv[2].split(".")[-1] != "xxd":
		print "input not xxd file"
		return
	m1 = sys.argv[1]
	m2 = sys.argv[2]
	output = sys.argv[3]

	m1 = merl_file(m1,m1.split(".")[-1])
	#m1.status()
	m2 = merl_file(m2,m2.split(".")[-1])
	#m2.status()

	linked = link_merl(m1,m2)
	#linked.status()
	#linked.content_status()

	with open(output,'w') as f:
		s = ""
		for line in linked.content:
			s += line + "\n"
		f.write(s)

if __name__=="__main__":
	if len(sys.argv) != 4:
		print "Missing operand in - python linker.py file1.xxd file2.xxd output.txt"
	else:
		main()
