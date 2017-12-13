function Get-Int
{
   Param($str)
   $number = 0
   if (![int]::TryParse($str, [ref]$number)){Write-Error "Couldn't get Int woops!"}
   $number
}

function Get-MaxMinRowDiffSum
{
   Param($fileName)
   $sum = 0

   get-content $fileName | %{
      $max = [int]::MinValue
      $min = [int]::MaxValue

      $_.Split($null) | %{
         $number = Get-Int $_
         if ($number -gt $max)
         {
            $max = $number
         }

         if ($number -lt $min)
         {
            $min = $number
         }
      }

      $diff = $max - $min
      $sum += $diff
      Write-Verbose "diff = $diff | sum = $sum "
   }
   $sum
}

function Get-RowDivisibileNumSum
{
   Param($fileName)
   $sum = 0

   get-content $fileName | %{
      $numbers = $_.Split($null)
      $notFound = $true 
      $foundDiv = 0
      for($i=0; $i -lt $numbers.Count -and $notFound; $i++)
      {
         $number = Get-Int $numbers[$i]
         for($j=$i+1; $j -lt $numbers.Count -and $notFound; $j++)
         {
            $numberTwo = Get-Int $numbers[$j]

            $div = $number / $numberTwo
            if (($div % 1) -eq 0)
            {
               $notFound = $false 
               Write-Verbose " div= $div | $number / $numberTwo"
               $sum += $div
            }
            $div = $numberTwo / $number
            if (($div % 1) -eq 0)
            {
               $notFound = $false 
               Write-Verbose " div= $div | $numberTwo / $number"
               $sum += $div
            }
         }
      }
   }
   $sum
}

$fileName = "../input/day2.txt"

$sum =  Get-MaxMinRowDiffSum $fileName
Write-host "Sum = $sum"

$sum = Get-RowDivisibileNumSum $fileName
Write-host "Sum = $sum"
