#
# QuickCheck: Randomised Testing for GAP Functions
#
# Implementations
#

QC_Skip := "SKIP TEST";

# Store the generators we support
DeclareOperation("QC_Filters", [IsObject]);

QC_RegisterFilterGen := function(filt, func)
    InstallMethod(QC_Filters, [filt], function(x) return func; end);
end;


InstallGlobalFunction(QC_MakeRandomArgument,
    function(object, rg, limit)
        local func, warningLevel, loop, val;
        # Handle filter case
        if IsFilter(object) then
            # Our usage of 'ApplicableMethodTypes' sometimes
            # makes warnings at level 1, so turn off the warnings
            warningLevel := InfoLevel(InfoWarning);
            SetInfoLevel(InfoWarning, 0);
            func := ApplicableMethodTypes(QC_Filters, [object]);
            SetInfoLevel(InfoWarning, warningLevel);
            if func = fail then
                ErrorNoReturn("Filter with no random generator: ", object);
            fi;
            for loop in [1..100] do
                val := func(true)(rg, limit);
                if object(val) then
                    return val;
                fi;
            od;
            ErrorNoReturn("Cannot make a value of type ", object);
        fi;

        if IsFunction(object) then
            return object(rg, limit);
        fi;

        ErrorNoReturn("Cannot make an object of type ", object);
    end);

_QC.defaultConfig := rec(tests := 500, limit := 9, ramp:= 30, seed := 1, catchErrors := true);

_QC.fillConfig := function(configlist)
    local r, retval, config;
    if Length(configlist) > 1 then
        ErrorNoReturn("Too many arguments to QC_Check");
    fi;

    retval := StructuralCopy(_QC.defaultConfig);

    if Length(configlist) = 1 then
        config := configlist[1];
        for r in RecNames(config) do
            if not IsBound(retval.(r)) then
                ErrorNoReturn("Invalid option: ", r);
            fi;
            retval.(r) := config.(r);
        od;
    fi;
    return retval;
end;

InstallGlobalFunction(QC_SetConfig,
    function(config)
        _QC.defaultConfig := _QC.fillConfig([config]);
    end);

InstallGlobalFunction(QC_GetConfig, {} -> ShallowCopy(_QC.defaultConfig));

_QC.LastFailure := rec();

_QC.Check := function(argtypes, func, configarg...)
        local testCount, skipCount, args, rg, call, ret, config, testSize, breakOnError, instream;

        config := _QC.fillConfig(configarg);

        rg := RandomSource(IsMersenneTwister, config.seed);

        testCount := 0;
        skipCount := 0;
        while testCount < config.tests and skipCount < config.tests * 100 do
            # start with smaller sized tests
            testSize := Minimum(Int((testCount+skipCount)/config.ramp)+1, config.limit);
            args := List(argtypes, {a} -> QC_MakeRandomArgument(a, rg, testSize));
            _QC.PreviousArguments := StructuralCopy(args);
            if config.catchErrors then
                breakOnError := BreakOnError;
                BreakOnError := false;
            fi;
            _QC.Function := func;
            _QC.Args := StructuralCopy(args);
            Unbind(_QC.Ret);
            instream := InputTextString("_QC.Ret := CallFuncListWrap(_QC.Function, _QC.Args);;");
            # READ_STREAM_LOOP gained extra argument in GAP 4.12
            if NumberArgumentsFunction(READ_STREAM_LOOP) = 2 then
                READ_STREAM_LOOP(instream, OutputTextUser());
            else
                READ_STREAM_LOOP(instream, OutputTextUser(), false);
            fi;

            if config.catchErrors then
                BreakOnError := breakOnError;
            fi;
            if IsBound(_QC.Ret) then
                ret := _QC.Ret;
            else
                ret := [];
            fi;
            CloseStream(instream);
            Unbind(_QC.Ret);
            # We leave _QC.Args and _QC.Function, so they can be returned by QC_LastFailure

            if IsEmpty(ret) then
                PrintFormatted("Test {} of {} did not return a value\n", testCount, config.tests);
                Print(" Input: ", args, "\n");
                return false;
            fi;

            ret := ret[1];

            if ret = QC_Skip then
                skipCount := skipCount + 1;
            elif ret <> true then
                PrintFormatted("Test {} of {} failed:\n", testCount, config.tests);
                Print(" Input: ", args,"\n");
                Print(" Output: ", ret,"\n");
                return false;
            else
                testCount := testCount + 1;
            fi;
        od;
        if testCount < config.tests then
            PrintFormatted("Too many tests skipped. Only managed {} out of {} tests\n", testCount, config.tests);
            return false;
        fi;
        Unbind(_QC.PreviousArguments);
        return true;
end;

InstallGlobalFunction(QC_Check,
    function(argtypes, func, configarg...)
        local ret, savefailure;
        savefailure := _QC.LastFailure;
        _QC.LastFailure := rec(func := func);
        ret := CallFuncList(_QC.Check, Concatenation([argtypes, func], configarg));
        if ret then
            _QC.LastFailure := savefailure;
        fi;
        return ret;
end);


InstallGlobalFunction(QC_CheckEqual,
    function(argtypes, funcL, funcR, configarg...)
        local funccheck, ret, savefailure;

        savefailure := _QC.LastFailure;
        _QC.LastFailure := rec(funcs := [funcL, funcR]);

        funccheck := function(args...)
            local retL, retR;
            retL := CallFuncListWrap(funcL, StructuralCopy(args));
            retR := CallFuncListWrap(funcR, args);
            if retL = [QC_Skip] or retR = [QC_Skip] then
                return QC_Skip;
            fi;

            if IsEmpty(retL) or IsEmpty(retR) then
                return "A least one function did no return a value";
            fi;

            retL := retL[1];
            retR := retR[1];

            if retL = retR then
                return true;
            fi;
            return StringFormatted("Return values differ: {} and {}", retL, retR);
        end;
        ret := CallFuncList(_QC.Check, Concatenation([argtypes, funccheck], configarg));
        if ret then
            _QC.LastFailure := savefailure;
        fi;
        return ret;
end);

InstallGlobalFunction(QC_LastFailure,
    function()
    if IsBound(_QC.Args) then
        return rec(func := _QC.Function, args := _QC.Args);
    else
        return fail;
    fi;
end);

InstallGlobalFunction(QC_RerunLastFailure,
    function()
    if IsBound(_QC.Args) then
        return CallFuncList(_QC.Function, _QC.Args);
    else
        return fail;
    fi;
end);
