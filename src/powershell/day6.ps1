
function PrintBlocks {
  Param(
     $arr
  )
  $str = ""
  foreach($a in $arr)
  {
     $str += " $a "
  }
  $str
}
$blocks = @(14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4)

$configurations = @()
$matchedConfiguration = $false
$step = 0

"Original: "
PrintBlocks $blocks

$hash = @{}
$hashStr = ""
foreach ($num in $blocks){$hashStr += $num}
$hash.Add($hashStr, 0)

while(!$matchedConfiguration)
{
  #PrintBlocks $blocks
  $step++
   $max = [int]($blocks |  Measure-Object -Maximum).Maximum
  $startNdx = $blocks.IndexOf([int]$max)
  $blocks[$startNdx] = 0

  for($i=0;$i -lt $max;$i++)
  {
     $startNdx++
     if($startNdx -ge $blocks.Count)
     {
        $startNdx = 0
     }
     $blocks[$startNdx]++
  }

  # Build hash string
  $hashStr = ""
  foreach ($num in $blocks){$hashStr += $num}

  if($hash.Contains($hashStr))
  {
     "found collision at Step $step"
    
     $diff = $step - $hash[$hashStr]
     "Diffrence of index $diff"
    
     break
  }

  $hash.Add($hashStr, $step)

  if($step % 500 -eq 0)
  {
     "Making progress $step ..."
  }
}