import React from "react";
import {Schedulerow} from "../entities/Schedulerow";

export const ScheduleItem: React.FC<Schedulerow> = ({name, time}) => {
    return (
        <div className="schedule-item">
            <section className="schedule-item-name">
                <p>{name}</p>
            </section>
            <p>{time}</p>
        </div>
    );
}
