#Get-Content .\tests\test.txt | .\A.exe
$task, $language = $args[0].split('.')
Write-Host 'Running task' $task':'

# Selecting command for proper language
if ($language -eq 'c') {
    cmd /c 'gcc.exe -static -fno-optimize-sibling-calls -fno-strict-aliasing -DONLINE_JUDGE -fno-asm -lm -s -Wl,--stack=268435456 -O2 -o' $task $args[0]
}
elseif ($language -eq 'cpp') {
    Write-Host 'c++'
}
else {
    Write-Host "The file you specified isn't supported by this script."
}

#
# if ($args[1] -ne $null) {
#     Write-Host 'empty'
# } 

