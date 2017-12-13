function KnotHash{
   Param(
      $lengths,
      $stdList,
      $currPos = 0,
      $skipSize = 0
   )

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
      
      $currPos = ($currPos + $skipSize + $length) % $stdList.Count
      $skipSize++
   }
   $properties = @{
      List=$stdList;
      Position=$currPos;
      SkipSize=$skipSize;
   }
   New-Object PSObject –Property $properties
}

function ConvertLengthsToAscii{
   Param(
      $lengthsStr
   )
   $asciiMap = @{','=44;'0'=48;'1'=49;'2'=50;'3'=51;'4'=52;'5'=53;'6'=54;'7'=55;'8'=56;'9'=57;}
   $suffix = @(17, 31, 73, 47, 23)
   $newLengths = @()

   $lengthsStr.ToCharArray() | %{
      $newLengths += $asciiMap[[string]$_]
   }
   $suffix | %{
      $newLengths += $_
   }

   $newLengths
}

function SparseHash{
   Param(
      $stdList,
      $lengths
   )
   $rounds = 64
   $pos = 0
   $skipSize = 0
   $list = $stdList
   for($i=0;$i -lt 64; $i++){
      
      $result = KnotHash $newLengths $list $pos $skipSize

      $list = $result.List
      $pos = $result.Position
      $skipSize = $result.SkipSize
   }
   $result
}

function DenseHash {
   Param(
      $list
   )
   $newList = @()
   while($list.Count -gt 0){
      $chunk = $list[0..15]
      $list = $list[16..$list.Count]
      $result = 0
      $chunk | %{
         $result = $result -bxor $_
      }
      $newList += $result
   }
   $newList
}

function DecToHex{
   Param(
      $list
   )
   $str = ""
   $list | %{
      $hexStr = [Convert]::ToString($_, 16)
      if ($hexStr.length -lt 2){
         $hexStr = "{0}{1}" -f 0, $hexStr
      }
      $str += $hexStr
   }
   $str
}

$stdList = (0..255)

# Part 1 37230
$lengths = @(147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70)
$list = (KnotHash $lengths $stdList).List
$product = $list[0] * $list[1]
"`r`nPart 1 product = $product`r`n"

# part2
$lengthsStr = "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70"
$newLengths = ConvertLengthsToAscii $lengthsStr

$sh = SparseHash $stdList $newLengths
$dh = DenseHash $sh.List
$hashStr = DecToHex $dh
"Part 2 Hash String = $hashStr`r`n"
