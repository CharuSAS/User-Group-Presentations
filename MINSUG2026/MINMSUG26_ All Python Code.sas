proc python;
    submit;
#3.1 indenting 
chictemp = [59, 60, 61, 62, 63]
for i in chictemp:
    celsius = (i - 32) * 5/9
    print('Temp for a canadian is:', celsius, 'celsius')
endsubmit;
run;

proc python;
    submit;
#3.1 Case sensitivity
city = 'Chicago'
print(City)
# This will output a NameError because
# the casing is not consistent.
endsubmit;
run;

proc python;
    submit;
#3.1 order of first occurrence
print(year)
year=2026
endsubmit;
run;

proc python;
    submit;
#3.2 built in functions
print('Hello')
a = 'Test'
print(type(a))
a = [5,1,0,3,2,4]
print(sorted(a))
endsubmit;
run;

proc python;
    submit;
#3.4 Variable names
a = 12
A = 'Twelve'
print(a,A)

υψος = 10
print(υψος)
endsubmit;
run;

proc python;
    submit;
#3.4 The operator + is used to concatenate 2 strings as the operation returns “hello world”
'hello' + ' world'
endsubmit;
run;

proc python;
    submit;
#3.4 The operator * is known as the repetition operator as the operation returns “hello hello”
'hello ' * 2
endsubmit;
run;

proc python;
    submit;
#3.4 string indexing
str = 'Hello'
print(str[0])
print(str[1])
print(str[2])
print(str[3])
print(str[4])
endsubmit;
run;

proc python;
    submit;
#3.4 string slicing
str = 'HELLO'
print(str[:])
print(str[0:])
print(str[:5])
print(str[:3])
print(str[0:2])
print(str[1:4])
endsubmit;
run;

proc python;
    submit;
#3.4 list containing diff data types
c=list(['fall','10','october'])
type(c)
endsubmit;
run;

proc python;
    submit;
#3.4 printing index position 1
print(c[1])
endsubmit;
run;

proc python;
    submit;
#3.4 printing index position 2
print(c[2])
endsubmit;
run;

proc python;
    submit;
#3.4 List slicing and operators
my = [1, 'hi', 'class', 2]
print(my[3:])
print(my[0:2])
print(my)
print(my + l)
print(my * 3)
endsubmit;
run;

proc python;
    submit;
#3.4 Python code comparison with DATA step
numbers = [2, 4, 6, 8, 10]
product = 1
for i in numbers:
    product = product * i
print('The product is:', product)

endsubmit;
run;