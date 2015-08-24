﻿unit TestMapReduce;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, SysUtils, MapReduce;

type
  // Test methods for class TMapReduce

  TestTMapReduce = class(TTestCase)
  private
    procedure ForEachAddTriangle(var X: string; const I: Integer; var Done: Boolean);
    procedure ForEachLAddTriangle(var X: string);

    function Map(const X: string; const I: Integer): string;
    function MapL(const X: string): string;

    function FilterLengthMoreThan1(const X: string; const I: Integer): Boolean;
    function FilterLLengthMoreThan1(const X: string): Boolean;

    function PredicateEndsWithTriangle(const X: string): Boolean;

    function Reduce(const Accumulator: string; const X: string; const I: Integer): string;
    function ReduceL(const Accumulator: string; const X: string): string;

    function MapTo(const X: string; const I: Integer): string;
    function MapToL(const X: string): string;

    function ReduceTo(const Accumulator: string; const X: string; const I: Integer): string;
    function ReduceToL(const Accumulator: string; const X: string): string;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestForEachArrChange;
    procedure TestForEachArrChange1;
    procedure TestForEachArrChange2;
    procedure TestForEachArrChange3;
    procedure TestForEach;
    procedure TestForEach1;
    procedure TestForEach2;
    procedure TestForEach3;
    procedure TestForEach4;
    procedure TestForEach5;
    procedure TestMap;
    procedure TestFilter;
    procedure TestReduce;
  end;

implementation

uses System.Generics.Collections, System.Types;

type
  TTestCaseList = class
    class function Create: TList<string>;
  end;

const
  c_std_arr: TStringDynArray = ['1', '22', '333', '4444'];
  c_tarray: TArray<string>   = ['1', '22', '333', '4444'];

  { TTestCaseList }

class function TTestCaseList.Create: TList<string>;
var
  ResultList: TList<string>;
begin
  ResultList := TList<string>.Create;
  TMapReduce<string>.ForEach(c_std_arr,
    procedure(const X: string)
    begin
      ResultList.Add(X);
    end);
  Result := ResultList;
end;

{ TestTMapReduce }

function TestTMapReduce.FilterLengthMoreThan1(const X: string; const I: Integer): Boolean;
begin
  if X.Length > 1 then
    Result := True
  else
    Result := False;
end;

function TestTMapReduce.FilterLLengthMoreThan1(const X: string): Boolean;
begin
  if X.Length > 1 then
    Result := True
  else
    Result := False;
end;

procedure TestTMapReduce.ForEachAddTriangle(var X: string; const I: Integer; var Done: Boolean);
begin
  X := X + StringOfChar('▲', I + 1);
  Done := False;
end;

procedure TestTMapReduce.ForEachLAddTriangle(var X: string);
begin
  X := X + '▲';
end;

function TestTMapReduce.Map(const X: string; const I: Integer): string;
begin
  Result := X + StringOfChar('▲', I + 1);
end;

function TestTMapReduce.MapL(const X: string): string;
begin
  Result := X + '▲';
end;

function TestTMapReduce.MapTo(const X: string; const I: Integer): string;
begin
  Result := X + StringOfChar('▲', I + 1);
end;

function TestTMapReduce.MapToL(const X: string): string;
begin
  Result := X + '▲';
end;

function TestTMapReduce.PredicateEndsWithTriangle(const X: string): Boolean;
begin
  Result := X.EndsWith('▲');
end;

function TestTMapReduce.Reduce(const Accumulator, X: string; const I: Integer): string;
begin
  Result := Accumulator + sLineBreak + X + StringOfChar('▲', I + 1);
end;

function TestTMapReduce.ReduceL(const Accumulator, X: string): string;
begin
  Result := Accumulator + sLineBreak + X;
end;

function TestTMapReduce.ReduceTo(const Accumulator, X: string; const I: Integer): string;
begin
  Result := Accumulator + sLineBreak + X + StringOfChar('▲', I + 1);
end;

function TestTMapReduce.ReduceToL(const Accumulator, X: string): string;
begin
  Result := Accumulator + sLineBreak + X;
end;

procedure TestTMapReduce.SetUp;
begin

end;

procedure TestTMapReduce.TearDown;
begin

end;

procedure TestTMapReduce.TestForEachArrChange;
var
  Source: TArray<string>;
begin
  // Setup method call parameters
  Source := Copy(c_tarray);
  // Testing
  TMapReduce<string>.ForEachArrChange(Source, ForEachAddTriangle);
  // Validate method results
  CheckTrue(TMapReduce<string>.Every(Source, PredicateEndsWithTriangle));
end;

procedure TestTMapReduce.TestForEachArrChange1;
var
  Source: TStringDynArray;
begin
  // Setup method call parameters
  Source := Copy(c_std_arr);
  // Testing
  TMapReduce<string>.ForEachArrChange(Source, ForEachAddTriangle);
  // Validate method results
  CheckTrue(TMapReduce<string>.Every(Source, PredicateEndsWithTriangle));
end;

procedure TestTMapReduce.TestForEachArrChange2;
var
  Source: TArray<string>;
begin
  // Setup method call parameters
  Source := Copy(c_tarray);
  // Testing
  TMapReduce<string>.ForEachArrChange(Source, ForEachLAddTriangle);
  // Validate method results
  CheckTrue(TMapReduce<string>.Every(Source, PredicateEndsWithTriangle));
end;

procedure TestTMapReduce.TestForEachArrChange3;
var
  Source: TStringDynArray;
begin
  // Setup method call parameters
  Source := Copy(c_std_arr);
  // Testing
  TMapReduce<string>.ForEachArrChange(Source, ForEachLAddTriangle);
  // Validate method results
  CheckTrue(TMapReduce<string>.Every(Source, PredicateEndsWithTriangle));
end;

procedure TestTMapReduce.TestFilter;
begin
  CheckTrue(Length(TMapReduce<string>.Filter(c_std_arr, FilterLengthMoreThan1))
    = Length(c_std_arr) - 1);
end;

procedure TestTMapReduce.TestMap;
begin
  CheckTrue(TMapReduce<string>.Every(TMapReduce<string>.Map(c_std_arr, Map),
    PredicateEndsWithTriangle));
end;

procedure TestTMapReduce.TestReduce;
var
  ResultValue: string;
begin
  ResultValue := TMapReduce<string>.Reduce(c_tarray, Reduce);
  CheckTrue(Length(ResultValue.Split([sLineBreak])) = Length(c_std_arr));
end;

procedure TestTMapReduce.TestForEach;
var
  Source: TList<string>;
  LoopCount: Integer;
begin
  // Setup method call parameters
  Source := TTestCaseList.Create;
  try
    LoopCount := 0;
    // Testing
    TMapReduce<string>.ForEach(Source,
      procedure(const X: string; const I: Integer; var Done: Boolean)
      begin
        if I = high(c_tarray) then
          Done := True
        else
        begin
          Done := False;
          Inc(LoopCount);
        end;
      end);
  finally
    FreeAndNil(Source);
  end;
  // Validate method results
  CheckTrue(LoopCount = Length(c_std_arr) - 1);
end;

procedure TestTMapReduce.TestForEach1;
var
  LoopCount: Integer;
begin
  // Setup method call parameters
  LoopCount := 0;
  // Testing
  TMapReduce<string>.ForEach(c_tarray,
    procedure(const X: string; const I: Integer; var Done: Boolean)
    begin
      if I = high(c_tarray) then
        Done := True
      else
      begin
        Done := False;
        Inc(LoopCount);
      end;
    end);
  // Validate method results
  CheckTrue(LoopCount = Length(c_tarray) - 1);
end;

procedure TestTMapReduce.TestForEach2;
var
  LoopCount: Integer;
begin
  // Setup method call parameters
  LoopCount := 0;
  // Testing
  TMapReduce<string>.ForEach(c_std_arr,
    procedure(const X: string; const I: Integer; var Done: Boolean)
    begin
      if I = high(c_std_arr) then
        Done := True
      else
      begin
        Done := False;
        Inc(LoopCount);
      end;
    end);
  // Validate method results
  CheckTrue(LoopCount = Length(c_std_arr) - 1);
end;

procedure TestTMapReduce.TestForEach3;
var
  Source: TList<string>;
  LoopCount: Integer;
begin
  // Setup method call parameters
  Source := TTestCaseList.Create;
  try
    LoopCount := 0;
    // Testing
    TMapReduce<string>.ForEach(Source,
      procedure(const X: string)
      begin
        Inc(LoopCount);
      end);
  finally
    FreeAndNil(Source);
  end;
  // Validate method results
  CheckTrue(LoopCount = Length(c_std_arr));
end;

procedure TestTMapReduce.TestForEach4;
var
  LoopCount: Integer;
begin
  // Setup method call parameters
  LoopCount := 0;
  // Testing
  TMapReduce<string>.ForEach(c_tarray,
    procedure(const X: string)
    begin
      Inc(LoopCount);
    end);
  // Validate method results
  CheckTrue(LoopCount = Length(c_tarray));
end;

procedure TestTMapReduce.TestForEach5;
var
  LoopCount: Integer;
begin
  // Setup method call parameters
  LoopCount := 0;
  // Testing
  TMapReduce<string>.ForEach(c_std_arr,
    procedure(const X: string)
    begin
      Inc(LoopCount);
    end);
  // Validate method results
  CheckTrue(LoopCount = Length(c_std_arr));
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTMapReduce.Suite);

end.