import React, {useEffect, useState} from 'react';
import {Schedule} from "../components/Schedule";
import {Schedulerow} from "../entities/Schedulerow";
import {baseUrl} from "../entities/BaseUrl";

const Home = (props: { name: string }) => {
    const [schedulerows, setSchedulerows] = useState([]);
    console.log("Home")
    useEffect(() => {
        (
            async () => {
                const response = await fetch(baseUrl + 'student/schedule', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    credentials: 'include',
                    body: JSON.stringify({
                        "username": props.name
                    })
                });
                if (!props.name) {
                    return
                }
                const content = await response.json();
                let sr: Schedulerow = {name: "", time: ""}
                for (let x in content) {
                    // here, cop stands for a copy. If we do not copy the value of sr, then we will be using the same
                    // 'sr' object throughout the 'schedulerows' array, which if changed, will be changed throughout array.
                    let cop = {...sr}
                    cop.name = content[x]["Name"]
                    cop.time = content[x]["Time"]
                    // @ts-ignore
                    setSchedulerows( arr => [...arr, cop]);
                }
                return
            }
        )();
    }, []);
    if (props.name) {
        return (
            <div>
                {'Hi ' + props.name}
                <br/>
                <label>Here is your Schedule:</label>
                <br/>
                <Schedule schedules={schedulerows}/>
                <br/>
            </div>
        );
    }
    else {
        return (
            <div>
                {'You are not logged in'}
            </div>
        );
    }
};

export default Home;
