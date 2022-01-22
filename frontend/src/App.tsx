import './App.css';
import {Header} from "./components/Header";
import './components/Header.css'
import {Schedule} from "./components/Schedule";
import React, {useEffect, useState} from 'react';
import Login from "./pages/Login";
import Nav from "./components/Nav";
import {BrowserRouter, Route, Routes} from "react-router-dom";
import Home from "./pages/Home";
import Register from "./pages/Register";
import {baseUrl} from "./entities/BaseUrl";
import GisMap from "./components/2gisMap";

function App() {
    const [name, setName] = useState('');
    console.log("App")
    useEffect(() => {
        (
            async () => {
                const response = await fetch( baseUrl + 'student/user', {
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    credentials: 'include',
                    // mode: 'cors'
                });

                const content = await response.json();

                setName(content.name);
            }
        )();
    }, []);


    return (
        <div className="App">
            <BrowserRouter>
                <Nav name={name} setName={setName}/>

                <main className="form-signin">
                    <Routes>
                        <Route path="/login" element={<Login setName={setName}/>}/>
                        <Route path="/register" element={<Register />}/>
                        <Route path="/" element={<Home name={name}/>}/>
                        <Route path="/map" element={<GisMap /> }/>
                    </Routes>
                </main>
            </BrowserRouter>
        </div>
    );
}
export default App;
