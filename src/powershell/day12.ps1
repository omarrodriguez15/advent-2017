function GetPipes {
  Param($content)
  $pipes = @()
 
  $content | %{
     $isLinkedToZero = $false
     $words = $_.Split(' ')
     $name = $words[0]

     if($name -eq 0){
        $isLinkedToZero = $true
     }

     $pipeList = @()
     for ($i=2;$i -lt $words.Count; $i++){
        $pipeName = $words[$i].Replace(',','')
        $pipeList += $pipeName
     }

     $pipes += New-Object PSObject -Property @{
        Name = $name;
        Pipes = $pipeList;
        IsLinkedToZero = $isLinkedToZero
     }
  }
  $pipes
}

function HowManyPipesConnect{
   Param($pipes, $mappedPipes, [int]$count, [int]$ndx)

   $pipe = $pipes[$ndx]
   $pipe.Pipes | %{
      $pipeName = [int]$_
      if(!$mappedPipes.ContainsKey($pipeName)){
         $count += 1
         $mappedPipes.Add($pipeName, $pipe.Name)
         $obj = HowManyPipesConnect $pipes $mappedPipes $count $pipeName
         $count = $obj.Count
      }
   }
   New-Object PSObject -Property @{
      Count = $count;
      MappedPipes = $mappedPipes;
   }
}

$content = Get-content "../input/day12.1.txt"

$pipes = GetPipes $content
$mappedPipes = @{}
$mappedPipes.Add(0, '0')
$pipeCount = $pipes.Count

$obj = HowManyPipesConnect $pipes $mappedPipes 1 0
$count = $obj.Count

"Programs that can pipe to 0 = $count"
"Pipe Count = $pipeCount"

# $groupCount = 1
# $mappedPipes = $obj.MappedPipes
# While($mappedPipes.Count -ne $pipeCount)
# {
#    $ndx = 0
#    for($i=0;$i -lt $pipes.Count; $i++){
#       if (!$mappedPipes.ContainsKey([int]$pipes[$i].Name)){
#          $ndx = $i
#          $mappedPipes.Add([int]$pipes[$i].Name, $ndx)
#          break
#       }
#    }
   
#    $obj = HowManyPipesConnect $pipes $mappedPipes $count $ndx
#    $groupCount++
#    $mappedPipes = $obj.MappedPipes
# }

# "Group Count = $groupCount"
