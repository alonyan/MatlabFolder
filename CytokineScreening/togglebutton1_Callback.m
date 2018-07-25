function togglebutton1_Callback(hObject,eventdata)
if get(hObject,'Value')
    set(hObject, 'ForegroundColor',[0 1 0])
else
    set(hObject, 'BackgroundColor',[1 0 0])
end