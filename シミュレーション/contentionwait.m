function[node] = contentionwait(node,place,slottime,i)

if (i == 1)||(i == 2)
    node(i).waittime = randi([place(1).int,2*place(1).int]) * slottime;
else
    node(i).waittime = randi([place(i-1).int,2*place(i-1).int]) * slottime;
end