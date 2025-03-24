    randomize();

    //access with global.pet.joy++ etc
    global.game = {
        struct_version: 0.1,
        ownername: "",
        living: 1,
        corns: 100,
        hunger: 20,
        health: 20,
        happiness: 20,
        clutter_exists: 0,
        current_pet_type: "",
        year: current_year,
        month: current_month,
        day: current_day,
        hour: current_hour,
        minute: current_minute,
        second: current_second,
        session_time: (current_time/1000),
        total_time: 0,
    }
    global.pet = {
        joy: 0,
        nonsense: 0,
        selfesteem: 0,
        enthusiasm: 0,
    };

    starter_pet = irandom_range(0,2);
    if (global.game.current_pet_type == "") {
        if (starter_pet == 0) global.game.current_pet_type = "chobo"; 
        if (starter_pet == 1) global.game.current_pet_type = "pomba";
        if (starter_pet == 2) global.game.current_pet_type = "dodati";
    }