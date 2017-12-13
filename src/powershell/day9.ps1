
Function FilterExclamations  {
 
   [cmdletbinding()]
   Param (
      [parameter(ValueFromPipeline)]
      $tokens
   )
   while ($tokens.Contains('!')) {
      $ndx = $tokens.IndexOf('!')
      $tokens = $tokens.Remove($ndx, 2)
   }
   $tokens
}

Function FilterGarbage  {
   [cmdletbinding()]
   Param(
      [parameter(ValueFromPipeline)]
      $tokenStr
   )
   $garbageCount = 0
   while ($tokenStr.Contains('<') -and $tokenStr.Contains('>')) {
      $openNdx = $tokenStr.IndexOf('<')
      $closeNdx = $tokenStr.IndexOf('>')
      $ndxDiff = ($closeNdx - $openNdx)
      $garbageCount += ($ndxDiff - 1)
      $count =  $ndxDiff + 1
      $tokenStr = $tokenStr.Remove($openNdx, $count)
   }
   # Part 2
   $garbageCount > $null
   $tokenStr
}

Function CountGroups  {
   [cmdletbinding()]
   Param(
      [parameter(ValueFromPipeline)]
      $tokenStr
   )
   $tokenStr = $tokenStr.Replace(",","")
   $tokens = $tokenStr.ToCharArray()
   $mystack = new-object system.collections.stack
   $count = 0

   $tokens | %{
      $token = $_
      if ($mystack.Count -le 0){
         $mystack.Push($token)
      }
      elseif ($token -eq '}') {
         $count += $mystack.Count
         $mystack.Pop() > $null
      }
      else
      {
         $mystack.Push($token)
      }
   }
   $count
}

$charStream = Get-Content "../input/day9.txt"
$tokens = $charStream.ToCharArray()

$charStream | FilterExclamations | FilterGarbage | CountGroups
