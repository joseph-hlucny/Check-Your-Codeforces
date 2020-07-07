#Get-Content .\tests\test.txt | .\A.exe
# $task, $language = $args[0].split('.')
# Write-Host 'Running task' $task':'

$test = Get-ChildItem -Include *.c
Write-Host $test

# Automatically detects task and language (c or c++) if no file name or test
# folder are provided.
if ($args[0] -eq $null -and $args[1] -eq $null) {
    $file = Get-ChildItem -Path $pwd\*.c*
    $task = $file.BaseName
    $extension = $file.Extension
}
else {
    $task, $extension = $args[0].split('.')
}

# Selecting command for proper language
if ($extension -eq 'c') {
    cmd /c 'gcc.exe -static -fno-optimize-sibling-calls -fno-strict-aliasing -DONLINE_JUDGE -fno-asm -lm -s -Wl,--stack=268435456 -O2 -o' $task $args[0]
}
elseif ($extension -eq 'cpp') {
    Write-Host 'c++'
}
else {
    Write-Host "The file you specified isn't supported by this script."
}

# if ($args[1] -ne $null) {
#     Write-Host 'empty'
# } 

