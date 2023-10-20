function toggleStop(src, event)
    global t;
    if strcmp(t.Running, 'on')
        stop(t);
        src.String = 'Resume';
    else
        start(t);
        src.String = 'E-Stop';
    end
end
