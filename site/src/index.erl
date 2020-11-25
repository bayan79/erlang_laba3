%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Welcome to Nitrogen123".

body() ->
    #container_12 { body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() }
    ]}.  

inner_body() ->
    client:init_app(['host1@127.0.0.1', 'host2@127.0.0.1']),

    Nodes = [node() | nodes()],
    [
        #h1 { text="table persons" },
        #panel { body=[#button{id=button, text=Node, postback={click, Node}}  || Node <- [all | Nodes] ]}, 
        #panel {id=info_area, body=[list_gen(all)]}, 
        # h2 {text="======== Add item ======="},
        #panel {body=[form_add_person()]}        

        , #table{rows=[#tablerow{cells=[#tablecell{id=history}]}]}
    ].
	 
fperson({Name, Age})->
    wf:f("~s (~s)", [Name, Age]);
fperson(_) -> "".

list_gen(Frag) ->
    wf:insert_bottom(history, #panel{text=client:get_all(Frag)}),

    [
        #h3{text=wf:f("Fragment: ~p", [Frag])},
        [#label{text=fperson(Item)} || Item <- client:get_all(Frag)]
    ].

get_fragments(Node) ->
    Tables = mnesia:system_info(tables),
    F_table_repls = fun(Table) -> mnesia:table_info(Table, active_replicas) end,
    Fragments = [X || X <- Tables, lists:member(Node, F_table_repls(X))],
    Fragments.

form_add_person() ->
    [
        #label{text="Name: "},
        #textbox{id=add_name},
        #br{},
        #label{text="Age: "},
        #textbox{id=add_age},
        #br{},
        #button{text="Add", postback=add}
    ].

event(add) ->
    Name = wf:q(add_name),
    Age = wf:q(add_age),
    client:add_person(Name, Age),
    wf:wire(#alert { text=wf:f("Добавлен: ~s", [fperson({Name, Age})]) });
event({click, all}) ->
    % wf:update(button, #button{text="Ooops"}),
    wf:insert_bottom(history, #panel{text=get_fragments(all)}),
    wf:replace(info_area, #panel{id=info_area, body=list_gen(all)});

event({click, Node}) ->
    % wf:update(button, #button{text="Ooops"}),
    wf:insert_bottom(history, #panel{text=get_fragments(Node)}),
    wf:replace(info_area, #panel{id=info_area, body=[list_gen(X) || X <- get_fragments(Node), X =/= schema]});
event(_) -> ok.
