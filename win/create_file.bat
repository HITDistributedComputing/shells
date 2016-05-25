@echo off 
for /l %%n in (1,1,6485) do (
type nobel.txt >> nobel_repeated
)