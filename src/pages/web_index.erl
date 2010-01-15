-module (web_index).
-include_lib ("nitrogen/include/wf.inc").
-compile(export_all).

main() -> 
	#template { file="./wwwroot/template.html"}.

title() ->
	"web_index".

body() ->

    Body = [
	    #label { text="Login:" },
	    #textbox { id=username, postback=login, next=password },
	    #br {},
	    #label { text="Password:" },
	    #password { id=password, postback=login, next=submit },
	    #br {},
	    #button { id=submit, text="Login", postback=login }
    ],
    wf:wire(submit, username, #validate { validators = [ #is_required { text="Required" }]}),
    wf:render(Body).

event(login) ->
    case db_users:validate_user(hd(wf:q(username)), hd(wf:q(password))) of
	{ valid, _ID } ->
	    io:format("User: ~s has logged in~n", [wf:q(username)]),
	    %wf:flash("Correct"),
	    wf:user(hd(wf:q(username))),
	    wf:redirect("dashboard");
	_ ->
	    wf:flash("Incorrect")
    end;

event(_) -> ok.

