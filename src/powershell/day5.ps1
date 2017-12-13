$content = Get-Content "../input/day5.txt"

$numbers = @()
foreach ($number in $content) { $numbers += [int]$number }

$escapedMaze = $false
$progress = 0
$printProgress = 500
$nextNdx = 0
$mazeSize = $numbers.Count

while (!$escapedMaze) {
  $progress++
  $currentNdx = $nextNdx
  $num = $numbers[$currentNdx]
  $nextNdx = $num + $currentNdx

  if ($nextNdx -ge $mazeSize)
  {
     "Found"
     $progress
     $escapedMaze = $true
     break
  }
  $numbers[$currentNdx]++


  if($progress % $printProgress -eq 0)
  {
     "Took $progress steps so far..."
  }
}