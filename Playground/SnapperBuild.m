classdef Snapper < handle
%init
    properties (Dependent=true)
        Delay
        Strobe
    end
    properties (Hidden=true)
        ArduinoSnapperPort
    end
    methods
        function obj = Snapper()
            ArduinoSnapperPort = serial('COM16','baudrate',9600);
            if strcmp(get(ArduinoSnapperPort,'status'),'closed')
                fopen(ArduinoSnapperPort);
            end
            obj.ArduinoSnapperPort = ArduinoSnapperPort;
        end
        
        %% set strobe length
        function set.Strobe(obj, strb)
            fwrite(obj.ArduinoSnapperPort,['strobe ,', num2str(strb)])
            tline = fgetl(obj.ArduinoSnapperPort);
        end
        %% get strobe length
        function Strobe = get.Strobe(obj)
        fwrite(obj.ArduinoSnapperPort,'PrintStrobe')
        tline = fgetl(ArduinoSnapperPort);
        Strobe = str2double(tline);
        end;
        
        %% set delay length
        strb = 1;
        fwrite(ArduinoSnapperPort,['strobe ,', num2str(dl)])
        tline = fgetl(ArduinoSnapperPort);
        %% get delay length
        fwrite(ArduinoSnapperPort,'PrintDelay')
        tline = fgetl(ArduinoSnapperPort);
        Delay = str2double(tline);
    end