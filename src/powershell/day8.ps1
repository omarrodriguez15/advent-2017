function EvaluateComparison {
  Param(
     [int]$left,
     $operator,
     [int]$right
  )

  if($operator -eq "=="){
     $left -eq $right
  }
  elseif($operator -eq "!="){
     $left -ne $right
  }
  elseif($operator -eq "<"){
     $left -lt $right
  }
  elseif($operator -eq ">"){
     $left -gt $right
  }
  elseif($operator -eq "<="){
     $left -le $right
  }
  elseif($operator -eq ">="){
     $left -ge $right
  }
}

$maxValue = [int]::MinValue
$maxRegister = "none"
$registers = @{}

Get-Content "../input/day8.txt" | %{
  $line = $_
  $tokens = $line.Split(" ")
  $registryName = $tokens[0]
  $registerValue = 0
 
  if($registers.ContainsKey($registryName)){
     $registerValue = [int]$registers[$registryName]
  }

  $valueToCompare = 0
  if($registers.ContainsKey($tokens[4])){
     $valueToCompare = [int]$registers[$tokens[4]]
  }
  $modifyRegister = EvaluateComparison $valueToCompare $tokens[5] $tokens[6]
 
  if($modifyRegister) {
     if($tokens[1] -eq "inc"){
        $registerValue += [int]$tokens[2]
     }
     elseif ($tokens -eq "dec") {
        $registerValue -= [int]$tokens[2]
     }
  }
  #part 2
  if($registerValue -gt $maxValue)
  {
     $maxValue = $registerValue
     $maxRegister = $registryName
  }

  if($registers.ContainsKey($registryName)){
     $registers[$registryName] = $registerValue
  }
  else {
     $registers.Add($registryName, $registerValue)
  }
}

#Part1
# $registers.Keys | %{
#    $rv = $registers[$_]
#    if($rv -gt $maxValue)
#    {
#       $maxRegister = $_
#       $maxValue = $rv
#    }
# }

"Reg = $maxRegister val= $maxValue"

