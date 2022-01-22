import React, {Component} from "react";
import { default as ReactSelect } from "react-select";
import { components } from "react-select";
import GetCourses from "./GetCourses";
import "./MultipleDropdown.css"

const sampleCourses = [
    { value: "calculus", label: "Calculus" },
    { value: "geometry", label: "Geometry" },
    { value: "biology", label: "Biology" },
    { value: "informatics", label: "Informatics" },
    { value: "kazakh literature", label: "Kazakh Literature" },
    { value: "physics", label: "Physics" },
    { value: "chemistry", label: "Chemistry" },
];

// var courses;
//
// let myProm = new Promise((resolve, reject) => {
//     let coursesClass = new GetCourses();
//     resolve(coursesClass);
// });
// myProm.then(
//     (coursesClass) => {
//         try {
//             coursesClass.componentDidMount();
//             return coursesClass
//         } catch (e) {
//             throw e
//         }
//     })
//     .then(
//         (coursesClass) => {
//             courses = coursesClass.state.courses
//         },
//         (e) => {
//             console.log(e)
//         }
//     )


// useEffect(() => {
//     (
//         async () => {
//             const response = await fetch('http://localhost:8000/api/user', {
//                 headers: {'Content-Type': 'application/json'},
//                 credentials: 'include',
//             });
//
//             const content = await response.json();
//
//             setName(content.name);
//         }
//     )();
// });

const Option = (props) => {
    return (
        <div>
            <components.Option {...props}>
                <input
                    type="checkbox"
                    checked={props.isSelected}
                    onChange={() => null}
                />{" "}
                <label>{props.label}</label>
            </components.Option>
        </div>
    );
};

export default class MultipleDropdown extends Component {
    constructor(props) {
        super(props);
        this.state = {
            optionSelected: null
            // options: []
        };
    }

    handleChange = (selected) => {
        this.setState({
            optionSelected: selected
        });


        // let value = Array.from(
        //     this.state.options,
        //     () => selected
        // );
        // this.setState({
        //     options: value,
        // });
    };

    render() {
        return (
            <span
                className="d-inline-block"
                data-toggle="popover"
                data-trigger="focus"
                data-content="Please select course(s)"
            >
        <ReactSelect className="form-control"
            options={sampleCourses}
            isMulti
            closeMenuOnSelect={false}
            hideSelectedOptions={false}
            components={{
                Option
            }}
            onChange={this.handleChange}
            allowSelectAll={true}
            value={this.state.optionSelected}
        />
      </span>
        );
    }
}