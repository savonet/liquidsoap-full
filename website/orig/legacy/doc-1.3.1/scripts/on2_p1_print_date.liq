def f()
  print(get_process_output("date"))
  42
end
# Let's use it:
print(f())
print(1+f())
