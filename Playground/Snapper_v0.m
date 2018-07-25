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
            tline = fgetl(obj.ArduinoSnapperPort);
            Strobe = str2double(tline);
        end;
        
        %% set delay length
        function set.Delay(obj, dl)
            fwrite(obj.ArduinoSnapperPort,['delay ,', num2str(dl)])
            tline = fgetl(obj.ArduinoSnapperPort);
        end
        %% get delay length
        function Delay = get.Delay(obj)
            fwrite(obj.ArduinoSnapperPort,'PrintDelay')
            tline = fgetl(obj.ArduinoSnapperPort);
            Delay = str2double(tline);
        end
        %% destructor
        function delete(obj)
            if strcmp(get(obj.ArduinoSnapperPort,'status'),'open')
                fclose(obj.ArduinoSnapperPort);
            end
        end
    end
end