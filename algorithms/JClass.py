#!usr/bin/python

class JClass:
    t = ["int","double","float"]
    
    def __init__(self, name, dependencies, v, m):
        self.name = name
        self.dependencies = dependencies
        self.vars = JVar.get_vars(v)
        self.methods = JMethod.get_methods(m)

    def __str__(self):
        #from imports to first line in class
        im = ""
        vs = ""
        for dep in self.dependencies:
            im += "import " + dep + ";\n"
        for v in self.vars:
            vs += "\t" + "private " + str(v) + ";\n"
        
        start = im + "\n" + "public class " + self.name + " {\n"
        
        #constructor
        init_vs = ""
        init_p = ""
        for v in self.vars:
            init_vs += str(v) + ", "
            init_p += "\t\t" + "this." + v.name + " = " + v.name + ";\n"
        init_vs = init_vs[:len(init_vs)-2] #take off comma space

        init = "\t" + "public " + self.name + " (" + init_vs + ") {\n" + init_p + "\t}\n"

        #instance methods
        mets = ""
        for me in self.methods:
            mets += str(me)
            
        return start + vs + init + mets + "}"

class JMethod:
    
    def __init__(self, (ret, name)):
        self.name = name
        self.args = []
        while True:
            f = raw_input("Enter the first argument for method " + name + ": ")
            if f == "":
            	print(f)
            	break
            else:
                self.args.append(f)
        p = raw_input("Enter return value: ")
        self.ret = p.split()
        self.ret = [self.ret[0], " ".join(self.ret[1:])]

    def __str__(self):
        a = ""
        for i in self.args:
            a += i + ", "
        a = a[:len(a)-2]
        
        f = "\t" + "public " + self.ret[0] + " " + self.name + " (" + a + ") {\n"
        r = "\t\t" + "return " + self.ret[1] + ";\n\t}\n"
        
        return f + r

    @staticmethod
    def get_methods(methods):
        meths = []
        for m in methods:
            meths.append(JMethod(m.split()))
        return meths

class JVar:
    
    def __init__(self, v):
        self.type = v[0]
        self.name = v[1]

    def __str__(self):
        s = self.type + " " + self.name
        return s

    @staticmethod
    def get_vars(v):
        vs = []
        for vm in v:
            vs.append(JVar(vm.split()))
        return vs

life = JClass("Life", ["java.io.*", "java.lang.Math", "java.util.*"], ["int a", "int b", "int c"], ["int add", "int subtract", "int multiply"])

f = open("Life.java", "w")
f.write(str(life))
f.close()
