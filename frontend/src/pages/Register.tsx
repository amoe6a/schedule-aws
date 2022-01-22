import React, {SyntheticEvent, useState} from 'react';
import {Navigate} from "react-router-dom";
import MultipleDropdown from "../components/MultipleDropdown";
import {baseUrl} from "../entities/BaseUrl";

const Register = () => {
    const [name, setName] = useState('');
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [groupName, setGroupName] = useState('x');
    const [courses, setCourses] = useState([]);
    const [redirect, setRedirect] = useState(false);
    const [message, setMessage] = useState("")

    const submit = async (e: SyntheticEvent) => {
        e.preventDefault();
        console.log(groupName)
        console.log(courses)
        const response = await fetch(baseUrl + 'student/register', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                "students": {
                    name,
                    username,
                    password
                },
                "group": {
                    groupName
                },
                "courses": {
                    courses
                }
            })
        });

        const content = await response.json();

        if (content.success === "true") {
            setRedirect(true);
            setMessage("")
        } else {
            setRedirect(false);
            setMessage(content.message)
        }
    }

    if (redirect) {
        return <Navigate to="/login"/>;
    }

    return (
        <form onSubmit={submit}>
            <h1 className="h3 mb-3 fw-normal">Please register</h1>

            <input className="form-control" placeholder="Name" required
                   onChange={e => setName(e.target.value)}
            />

            <input type="username" className="form-control" placeholder="Username" required
                   onChange={e => setUsername(e.target.value)}
            />

            <input type="password" className="form-control" placeholder="Password" required
                   onChange={e => setPassword(e.target.value)}
            />

            <div className="form-control">
                <label>Pick your group:</label>
                <select className="group-select" required onChange={e => setGroupName(e.target.value)}>
                    <option value="x">X</option>
                    <option value="y">Y</option>
                    <option value="z">Z</option>
                </select>
            </div>

            <MultipleDropdown onChange={(e: { target: { values: React.SetStateAction<never[]>; }; }) => setCourses(e.target.values)} />

            <button className="w-100 btn btn-lg btn-primary" type="submit">Submit</button>
            <p>{message}</p>
        </form>
    );
};

export default Register;

