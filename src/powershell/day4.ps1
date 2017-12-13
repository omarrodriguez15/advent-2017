$content = Get-content "../input/day4.txt"
$invalidPasswordCount = 0
$lineCount = 0

foreach($line in $content)
{
   $lineCount++
   $hash = @{}

   foreach($word in $line.split(" "))
   {
      if($hash.Contains($word))
      {
         $invalidPasswordCount++
         break
      }
      $hash.Add($word, "value")
   }
}

$lineCount - $invalidPasswordCount

$content = Get-Content  "../input/day4.txt"
$lineCount = 0
$invalidLines = 0
$invalidLine = $false

foreach($line in $content)
{
  $invalidLine = $false
  $words = $line.Split(" ")
  $lineCount++

  for($i=0; $i -lt $words.Count -and !$invalidLine; $i++)
  {
     $leftWord = $words[$i]

     for($j=($i+1); $j -lt $words.Count -and !$invalidLine; $j++)
     {
        $rightWord = $words[$j]
        $tempLeft = $leftWord
        $collisions = 0
        foreach($char in $rightWord.ToCharArray())
        {
           if($tempLeft.Contains($char))
           {
              $ndx = $tempLeft.IndexOf($char)
              $tempLeft = $tempLeft.Remove($ndx, 1)
              $collisions++
           }
        }

        if($collisions -eq $rightWord.Length -and $tempLeft.Length -eq 0)
        {
           "r=$rightWord l=$leftWord tl= $tempLeft"
           $invalidLine = $true
           $invalidLines++
        }
     }
  }
}
"Lc=$lineCount IL=$invalidLines"

$lineCount - $invalidLines

#119 117 114
