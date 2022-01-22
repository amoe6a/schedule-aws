import React, {SyntheticEvent, useState} from 'react';
import {Navigate} from "react-router-dom";
import MultipleDropdown from "../components/MultipleDropdown";
import {baseUrl} from "../entities/BaseUrl";

const GisMap = () => {
    const DG = require('2gis-maps');
    const map = DG.map('map', {
        'center': [54.98, 82.89],
        'zoom': 13
    });
    DG.marker([54.98, 82.89]).addTo(map).bindPopup('Вы кликнули по мне!');
    return (
        <body>
            <div id="map"/>
        </body>
    )
};

export default GisMap;