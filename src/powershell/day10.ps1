$lengths = @(147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70)
$stdList = (0..255)
# $lengths = @(3,4,1,5)
# # 0 1 2 3 4
# $stdList = (0..4)
# # end = 3 4 2 1 [0]

$currPos = 0
for ($i=0;$i -lt $lengths.Count;$i++) {
  $length = $lengths[$i]
 
  $firstSubList = $stdList[$currPos..($currPos + ($length - 1))]
  $secondSubList = $null
  if (($currPos + $length) -gt $stdList.Count){
     $remainder = ($currPos + $length) % $stdList.Count
     $secondSubList = $stdList[0..($remainder - 1)]
  }
 
  $ndx=0
  if($secondSubList.Count -gt 0){
     $reverseList = $firstSubList + $secondSubList
  }
  else{
     $reverseList = $firstSubList
  }
  $reverseList = $reverseList[-1..-$reverseList.Count]

  for ($j=$currPos; $j -lt $stdList.Count -and $ndx -lt $reverseList.Count;$j++){
     $stdList[$j] = $reverseList[$ndx]
     $ndx++
  }
  
  for ($j=0; $j -lt $stdList.Count -and $ndx -lt $reverseList.Count;$j++){
     $stdList[$j] = $reverseList[$ndx]
     $ndx++
  }
  # skipSize = $i
  $currPos = ($currPos + $i + $length) % $stdList.Count
}

$product = $stdList[0] * $stdList[1]
"stdList= $stdList product= $product"