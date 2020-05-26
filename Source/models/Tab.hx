package models;
class Tab
{
    @:isVar var name(get, set):String;
    @:isVar var text(get, set):String;

    public function new(name, text)
    {
        this.name = name;
        this.text = text;
    }

    function get_name():String {
        return name;
    }

    function set_name(value:String):String {
        return this.name = value;
    }

    function get_text():String {
        return text;
    }

    function set_text(value:String):String {
        return this.text = value;
    }
}