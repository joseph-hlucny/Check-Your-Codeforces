$test = Get-ChildItem -Include *.c
Write-Host $test
$test_counter = 1
$test_file_location = '.\tests\'

# Automatically detects task and language.
$file = Get-ChildItem -Path * -Include ('*.cpp', '*.c', '*.pl')
$task = $file.BaseName
$extension = $file.Extension


Write-Host 'Running task' $task':'`n

# Selecting compile command for proper language. Options based on Codeforces competition standards
if ($extension -eq '.c') {
    cmd /c 'gcc.exe -static -fno-optimize-sibling-calls -fno-strict-aliasing -DONLINE_JUDGE -fno-asm -lm -s -Wl,--stack=268435456 -O2 -o' $task $task$extension
}
elseif ($extension -eq '.cpp') {
    cmd /c 'g++.exe -std=c++11 -o' $task $task$extension
}
elseif ($extension -ne '.pl') {
    Write-Host "The file you specified isn't supported by this script."
}

# Sets file location for input, output, and solution for test cases
$input = Get-ChildItem -Path .\$test_file_location\$test_counter'*in*'
$output = Get-ChildItem -Path .\$test_file_location\$test_counter'*out*'
$solution = Get-ChildItem -Path .\$test_file_location\$test_counter'*sln*'

# Compares the differences between expected results and actual results for each test case.
# If the input file is empty, it will not run that test case.
while ($input -ne $null -and $input.length -gt 0) {
    Write-Host 'Test '$test_counter

    # Selects which command to run based on the language being used.
    switch ($extension) {
        '.c' { cmd.exe /c "$task.exe < $($input.FullName) > $($output.FullName)"; Break }
        '.cpp' { cmd.exe /c "$task.exe < $($input.FullName) > $($output.FullName)"; Break }
        '.pl' { cmd.exe /c "perl $task.pl < $($input.FullName) > $($output.FullName)"; Break }
    }

    # Start-Process $task -RedirectStandardInput $input.FullName -RedirectStandardOutput $output.FullName
    fc.exe /n /w $solution.FullName $output.FullName
    $test_counter = $test_counter + 1
    $input = Get-ChildItem .\$test_file_location\$test_counter'*in*'
    $output = Get-ChildItem .\$test_file_location\$test_counter'*out*'
    $solution = Get-ChildItem .\$test_file_location\$test_counter'*sln*'
}
