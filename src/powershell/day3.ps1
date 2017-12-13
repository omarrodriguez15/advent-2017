######################### Start Day 3 #################################




<#
265149
sqrt 514

37 36    35   34   33   32   31
38	17    16   15   14   13   30
39	18    5    4    3    12   29
40	19    6    1    2    11   28      1
41	20    7    8    9    10   27      3
42	21    22   23   24   25   26      5 
43 44    45   46   47   48   49      7

1821+257
438

                  265149
264711......264968......265225  515
#>


$gridSize = 9

#to the right one space of center
$centerNdx = [math]::Ceiling($gridSize / 2)

for($i=0; $i -lt $gridSize;$i++)
{
   $row = @()
   for($j=0;$j -lt $gridSize;$j++)
   {
      $row += 0
   }
   $grid +=, $row
}

$rowNdx = $centerNdx - 1
$colNdx = $centerNdx
$grid[$rowNdx][$colNdx - 1] = 1
$nextAllowed = 'u'

for($i=0; $i -lt ($gridSize * $gridSize);$i++)
{
   #"Column = $colNdx Row= $rowNdx"
   $nextDirection = $null

   $upNdx = $rowNdx - 1
   if($upNdx -lt 0)
   {
      $up = 0
   }
   else
   {
      $up = $grid[$upNdx][$colNdx]
      if ($up -eq 0 -and ($upNdx -ge 0) -and $nextAllowed.Contains('u')) 
      {
         $nextDirection = 'u' 
         $nextAllowed = "ul"
      }
   }

   $leftNdx = $colNdx - 1
   if($leftNdx -lt 0)
   {
      $left = 0
   }
   else
   {
      $left = $grid[$rowNdx][$leftNdx]
      if ($left -eq 0 -and ($leftNdx -ge 0) -and $nextAllowed.Contains('l')) 
      { 
         $nextDirection = 'l'
         $nextAllowed = "ld"
      }
   }

   $rightNdx = $colNdx + 1
   if($rightNdx -ge $gridSize)
   {
      $right = 0
   }
   else
   {
      $right = $grid[$rowNdx][$rightNdx]
      if ($right -eq 0 -and ($rightNdx -lt $gridSize) -and $nextAllowed.Contains('r')) 
      { 
         $nextDirection = 'r'
         $nextAllowed = "ru"
      }
   }

   $downNdx = $rowNdx + 1
   if($downNdx -ge $gridSize)
   {
      $down = 0
   }
   else
   {
      $down = $grid[$downNdx][$colNdx]
      if ($down -eq 0 -and ($downNdx -lt $gridSize) -and $nextAllowed.Contains('d')) 
      { 
         $nextDirection = 'd' 
         $nextAllowed = "dr"
      }
   }
   
   $downLeftRow = $rowNdx + 1
   $downLeftCol = $colNdx - 1
   if ($downLeftCol -lt 0 -or $downLeftRow -ge $gridSize)
   {
      $downLeft = 0
   } 
   else
   {
      $downLeft = $grid[$downLeftRow][$downLeftCol]
   }

   $downRightRow = $rowNdx + 1
   $downRightCol = $colNdx + 1
   if ($downRightCol -ge $gridSize -or $downRightRow -ge $gridSize)
   {
      $downRight = 0
   } 
   else
   {
      $downRight = $grid[$downRightRow][$downRightCol]
   }

   $upRightRow = $rowNdx - 1
   $upRightCol = $colNdx + 1
   if ($upRightCol -ge $gridSize -or $upRightRow -lt 0)
   {
      $upRight = 0
   } 
   else
   {
      $upRight = $grid[$upRightRow][$upRightCol]
   }

   $upLeftRow = $rowNdx - 1
   $upLeftCol = $colNdx - 1
   if ($upLeftCol -lt 0 -or $upLeftRow -lt 0)
   {
      $upLeft = 0
   } 
   else
   {
      $upLeft = $grid[$upLeftRow][$upLeftCol]
   }

   $sum = $up + $left + $down + $right + $downLeft + $downRight + $upRight + $upLeft
   if($sum -ge 265149)
   {
      "Found SUM = $sum"
      break
   }
   $grid[$rowNdx][$colNdx] = $sum

   if($nextDirection -eq 'u')
   {
      $rowNdx = $rowNdx - 1
   }
   if($nextDirection -eq 'l')
   {
      $colNdx = $colNdx - 1
   }
   if($nextDirection -eq 'd')
   {
      $rowNdx = $rowNdx + 1
   }
   if($nextDirection -eq 'r')
   {
      $colNdx = $colNdx + 1
   }
}

foreach ($b in $grid) {"   $b    "}


######################### End Day 3 ##########################################