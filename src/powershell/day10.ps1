function KnotHash{
   Param(
      $lengths,
      $stdList
   )

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
   $stdList
}


#Part 1
$lengths = @(147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70)
$stdList = (0..255)
$result = KnotHash $lengths $stdList
$product = $result[0] * $result[1]
"stdList= $result product= $product"

# part2
# $lengthsStr = "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70"
# $asciiMap = @{','=44;'0'=48;'1'=49;'2'=50;'3'=51;'4'=52;'5'=53;'6'=54;'7'=55;'8'=56;'9'=57;}
# $suffix = @(17, 31, 73, 47, 23)
# $newLengths = @()

# $lengthsStr.ToCharArray() | %{
#    $newLengths += $asciiMap[[string]$_]
# }
# $suffix | %{
#    $newLengths += $_
# }

