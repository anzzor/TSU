program TypesOfSort;

uses SysUtils, Windows;

procedure SimpleSort(var Mass: array of integer; len: integer);

var
  i: integer;
  temp: integer;

begin

  i := 0;
  while i < len - 1 do
  begin

         i := i + 1;

    if Mass[i - 1] > Mass[i] then
    begin
      temp := Mass[i - 1]; Mass[i - 1] := Mass[i]; Mass[i] := temp;
      i := 0;
    end;

  end;

end;

procedure QuadraticSort(var Mass: array of integer; count: integer);

var
  i, j: integer;
  time: integer;

begin

  for i := 0 to count - 2 do
  begin

    j := i; time := Mass[i + 1];

    while (j >= 0) and (Mass[j] > time) do
    begin
      Mass[j + 1] := Mass[j];
      j := j - 1;
    end;

    Mass[j + 1] := time;

  end;

end;

procedure Merge(var Mass: array of integer; array1, array2: array of integer);

var
  MassArrayId, array1Id, array2Id: integer;

begin

  array1Id := 0;
  array2Id := 0;
  MassArrayId := 0;

  while (array1Id < length(array1)) and (array2Id < length(array2)) do
  begin

    if (array1[array1Id] <= array2[array2Id]) then
    begin
      Mass[MassArrayId] := array1[array1Id];
      array1Id := array1Id + 1
    end

    else
    begin
      Mass[MassArrayId] := array2[array2Id];
      array2Id := array2Id + 1
    end;

    MassArrayId := MassArrayId + 1;

  end;

  while (array1Id < length(array1)) do
  begin
    Mass[MassArrayId] := array1[array1Id];
    array1Id := array1Id + 1;
    MassArrayId := MassArrayId + 1;
  end;

  while (array2Id < length(array2)) do
  begin
    Mass[MassArrayId] := array2[array2Id];
    array2Id := array2Id + 1;
    MassArrayId := MassArrayId + 1;
  end;

end;


procedure MergeSort(var Mass: array of integer);

var
  left, right: array of integer;
  i: integer;

begin

  if length(Mass) > 1  then
  begin

    setlength(left, length(Mass) div 2);
    setlength(right, length(Mass) - (length(Mass) div 2));

    for i := 0 to (length(Mass) div 2) - 1 do
      left[i] := Mass[i];

    for i := length(Mass) div 2 to length(Mass) - 1 do
      right[i-(length(Mass) div 2)] := Mass[i];

    MergeSort(left);
    MergeSort(right);
    Merge(Mass, left, right);

  end;

end;


function Test(var Mass, MassSort: array of integer; n : integer): Boolean;

var
  MassCount, MassSortCount: array [-999..999] of longint;
  i : longint;

begin

  i := 0;
  while (i < n - 1) and (MassSort [i] <= MassSort [i + 1]) do
    i := i + 1;

  if i < n - 1 then Test := False

  else
  begin

    for i := -999 to 999 do
    begin
      MassCount[i] := 0;
      MassSortCount [i] := 0;
    end;

    for i:= 0 to n - 1 do
    begin
      MassCount [Mass [i]]:= MassCount [Mass[i]]+ 1;
      MassSortCount [MassSort[i]] := MassSortCount [MassSort[i]] + 1;
    end;

    i := -999;
    while (i <= 999) and (MassCount [i]= MassSortCount [i]) do
      i := i + 1;

    if i = 1000 then Test := True

    else Test := False;

  end;

end;


var
    Mass: array of integer;                                            // Array with random numbers.
    MassSort: array of integer;                                       // Array to check.
    i: integer;                                                      // For cycles.
    count: integer;                                                 // Counter.
    CommonUserTime: int64;                                         // Store the process time.
    ProcessStartTime, ProcessEndTime,
    ProcessStartKernelTime, ProcessEndKernelTime,
    ProcessStartUserTime, ProcessEndUserTime: FILETIME;


begin

  randomize;
  count := 1;

  while count <= 1000000 do
  begin

    if (count = 10) or (count = 100) or (count = 1000) or (count = 10000) or (count = 100000) or (count = 1000000) then
    begin

      setlength(Mass, count);
      setlength(MassSort, count);

      for i := 0 to count - 1 do
      begin
        Mass[i] := random(1000);
        MassSort[i] := Mass[i];
      end;

      writeln('The length of the array is ', count);
      writeln;

      if (count <= 1000) then
      begin
        GetProcessTimes(GetCurrentProcess(), ProcessStartTime, ProcessEndTime, ProcessStartKernelTime, ProcessStartUserTime);

        SimpleSort(Mass, count);

        GetProcessTimes(GetCurrentProcess (), ProcessStartTime, ProcessEndTime, ProcessEndKernelTime, ProcessEndUserTime);
        CommonUserTime := int64(ProcessEndUserTime) - int64(ProcessStartUserTime);

        if Test(MassSort, Mass, count) then
          writeln('Simple sort successful: TRUE');

        writeln('Simple sort took: ', (CommonUserTime/1000000):6:2);
        writeln;
      end;

      for i := 0 to count - 1 do
        MassSort[i] := Mass[i];

      if (count <= 100000) then
      begin
        GetProcessTimes(GetCurrentProcess(), ProcessStartTime, ProcessEndTime, ProcessStartKernelTime, ProcessStartUserTime);

        QuadraticSort(Mass, count);

        GetProcessTimes(GetCurrentProcess (), ProcessStartTime, ProcessEndTime, ProcessEndKernelTime, ProcessEndUserTime);
        CommonUserTime := int64(ProcessEndUserTime) - int64(ProcessStartUserTime);

        if Test(MassSort, Mass, count) then
          writeln('Quadratic sort successful: TRUE');

        writeln('Quadratic sort took: ', (CommonUserTime/1000000):6:2);
        writeln;
      end;

      for i := 0 to count - 1 do
        Mass[i] := MassSort[i];

      GetProcessTimes(GetCurrentProcess(), ProcessStartTime, ProcessEndTime, ProcessStartKernelTime, ProcessStartUserTime);

      MergeSort(Mass);

      GetProcessTimes(GetCurrentProcess (), ProcessStartTime, ProcessEndTime, ProcessEndKernelTime, ProcessEndUserTime);
      CommonUserTime := int64(ProcessEndUserTime) - int64(ProcessStartUserTime);

      if Test(MassSort, Mass, count) then
        writeln('Merge sort successful: TRUE');

      writeln('Merge sort took: ', (CommonUserTime/1000000):6:2);
      writeln;

      writeln('-------------------------------------------------------------------- ');

    end;

    count := count * 10;

  end;

  writeln('Press any key to comtinue...');

  readln

end.
