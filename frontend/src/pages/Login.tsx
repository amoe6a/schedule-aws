import React, {SyntheticEvent, useState} from 'react';
import {Navigate} from "react-router-dom";
import {baseUrl} from "../entities/BaseUrl";

const Login = (props: { setName: (name: string) => void }) => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [redirect, setRedirect] = useState(false);

    const submit = async (e: SyntheticEvent) => {
        e.preventDefault();
        console.log(username)
        console.log(password)
        const response = await fetch(baseUrl + 'student/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            credentials: 'include',
            body: JSON.stringify({
                "username": username,
                "password": password
            })
        });

        const content = await response.json();

        if (content.message.length > 0) {
            setRedirect(false)
            window.alert(content.message)
        }
        else {
            setRedirect(true);
            props.setName(content.name);
        }
    }

    if (redirect) {
        return <Navigate to="/"/>;
    }
    else {
        return (
            <form onSubmit={submit}>
                <h1 className="h3 mb-3 fw-normal">Please sign in</h1>
                <input type="username" className="form-control" placeholder="Username" required
                       onChange={e => setUsername(e.target.value)}
                />

                <input type="password" className="form-control" placeholder="Password" required
                       onChange={e => setPassword(e.target.value)}
                />

                <button className="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>
            </form>
        );
    }
};

export default Login;
