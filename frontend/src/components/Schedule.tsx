import React from "react";
import {Schedulerow} from "../entities/Schedulerow";
import {ScheduleItem} from "./ScheduleItem";
import './Schedule.css'
import './ScheduleItem.css'

type Props = {
    schedules: Schedulerow[]
}

export const Schedule: React.FC<Props> = ({ schedules }) => {
    return (
        <ul className="schedule">
            {
                schedules.map((schedule, i) => (
                    <li key={i}>
                        <ScheduleItem
                            name={schedule.name}
                            time={schedule.time}
                        />
                    </li>
                ))
            }
        </ul>
    )
}


