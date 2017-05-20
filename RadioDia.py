from tkinter import *
def sel():
       temp = int(var.get())
       selection = "你已选择" + str(LANGS[temp-1][0])
       label.config(text = selection)

select = Tk()
select.title("请选择")
group = LabelFrame(select,text="请选择你的操作系统架构",padx=10,pady=20)
group.pack(padx=20,pady=20)
var = IntVar()
var.set(1)
LANGS=[("X86",1),("X64",2),("ARM (树莓派)",3)]
for lang,num in LANGS:
    diaBtn = Radiobutton(group,text=lang,variable=var,value=num,command=sel)
    diaBtn.pack(anchor = W)
label = Label(select)
label.pack()
selectBtn = Button(select,text="确认",fg="white",command = select.quit).pack(side=TOP)
mainloop()
print (int((var.get())))
