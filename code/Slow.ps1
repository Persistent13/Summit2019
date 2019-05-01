$array_timer = Measure-Command -Expression {
    $arr = @()
    1..10000 | ForEach-Object {
        $arr += $_
    }
}
$tc.TrackMetric('array loop', $array_timer.TotalMilliseconds)
$array_timer.TotalMilliseconds

$list_timer = Measure-Command -Expression {
    $list = [System.Collections.Generic.List[int]]::new()
    1..10000 | ForEach-Object {
        $list.Add($_)
    }
}
$tc.TrackMetric('list loop', $list_timer.TotalMilliseconds)
$list_timer.TotalMilliseconds

$tc.Flush()
