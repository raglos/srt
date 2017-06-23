BEGIN{
    FS="::::::";
}

# 
# 00:00:00,000 --> 00:00:00,000
#
function convert_time(tstr) {
    
    h1 = substr (tstr, 0, 3);
    m1 = substr (tstr, 4, 2);
    s1 = substr (tstr, 7, 2);
    i1 = substr (tstr, 10, 3);

    h2 = substr (tstr, 18, 2);
    m2 = substr (tstr, 21, 2);
    s2 = substr (tstr, 24, 2);
    i2 = substr (tstr, 27, 3);

    #
    # Convert each timestring to an int (ms)
    #

    time_ms1 = 0;
    time_ms1 += ( h1 * 60 * 60 * 1000);
    time_ms1 += ( m1 * 60 * 1000);
    time_ms1 += ( s1 * 1000);
    time_ms1 += i1;

    time_ms2 = 0;
    time_ms2 += ( h2 * 60 * 60 * 1000);
    time_ms2 += ( m2 * 60 * 1000);
    time_ms2 += ( s2 * 1000);
    time_ms2 += i2;

    #
    # Reduce both times by _DIFF ( -v )
    #

    time_ms1 += _DIFF;
    time_ms2 += _DIFF;


    #
    # convert new time in ms to old format again
    #

    h1 = 0; m1 = 0; s1 = 0; i1 = 0;
    h2 = 0; m2 = 0; s2 = 0; i2 = 0;

    i1 = time_ms1 % 1000;
    i2 = time_ms2 % 1000;

    s1 = time_ms1 / 1000;
    s2 = time_ms2 / 1000;

    h1 = s1 / 3600;
    h2 = s2 / 3600;

    m1 = s1 / 60 % 60;
    m2 = s2 / 60 % 60;

    s1 = s1 % 60;
    s2 = s2 % 60;
    
    #
    # format output and return new ""time string""
    #

    return sprintf ("%.2d:%.2d:%.2d,%.3d --> %.2d:%.2d:%.2d,%.3d",
                    h1, m1, s1, i1, h2, m2, s2, i2);

}

{
    _ID   = $1;
    _TIME = convert_time($2);
    _CONT = "";
    for (i=3; i<=NF; i++) {
        _CONT = _CONT ""$i"\n";
    }
    _CONT = _CONT "\n";

    printf ("%d\n%s\n%s", _ID, _TIME, _CONT);
}
