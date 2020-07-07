#Get-Content .\tests\test.txt | .\A.exe
# $task, $language = $args[0].split('.')
# Write-Host 'Running task' $task':'

$test = Get-ChildItem -Include *.c
Write-Host $test
$test_counter = 1
$test_file_location = '.\tests\'

# Automatically detects task and language (c or c++) if no file name or test
# folder are provided.
if ($args[0] -eq $null -and $args[1] -eq $null) {
    $file = Get-ChildItem -Path .\*.c*
    $task = $file.BaseName
    $extension = $file.Extension
    $run_tests = $true
}
# Either user only specified file to compile and wants to run no tests, or user
# specified file to compile and a custom directory for the test cases.
else {
    $task, $extension = $args[0].split('.')
    if ($args[1] -eq $null) {
        $run_tests = $false
    } else {
        $test_file_location = $args[1]
    }
}

# Selecting compile command for proper language. Options based on Codeforces competition standards
if ($extension -eq '.c') {
    cmd /c 'gcc.exe -static -fno-optimize-sibling-calls -fno-strict-aliasing -DONLINE_JUDGE -fno-asm -lm -s -Wl,--stack=268435456 -O2 -o' $task $task$extension
}
elseif ($extension -eq 'cpp') {
    Write-Host 'c++'
}
else {
    Write-Host "The file you specified isn't supported by this script."
}

# Compares the differences between expected results and actual results for each test case
$input = Get-ChildItem -Path .\$test_file_location\$test_counter'*in*'
$output = Get-ChildItem -Path .\$test_file_location\$test_counter'*out*'
while ($input -ne $null) {
    Write-Host 'Test '$test_counter
    fc.exe /n $input.FullName $output.FullName
    $test_counter = $test_counter + 1
    $input = Get-ChildItem -Path .\$test_file_location\$test_counter'*in*'
    $output = Get-ChildItem -Path .\$test_file_location\$test_counter'*out*'
}
