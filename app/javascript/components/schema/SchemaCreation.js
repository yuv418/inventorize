import React from "react"
import PropTypes from "prop-types"
class SchemaCreation extends React.Component {
  constructor(props) {
    super(props);
    if (!props.fields) {
      props.fields = [];
    }
    this.state = {
      fields: props.fields,
      autofill_mapping: props.autofill_mapping,
      autofill: props.autofill,
      autofillers: [],
      autofill_fields: [],
      autofiller: props.autofiller
    }

    this.addField = this.addField.bind(this);
    this.removeField = this.removeField.bind(this);
    this.changeAutofill = this.changeAutofill.bind(this);
    this.autofillFields = this.autofillFields.bind(this);
    this.updateAutofillMapping = this.updateAutofillMapping.bind(this);
    this.loadAutofillers();
    this.loadAutofillFields();
  }

  loadAutofillers() {
    fetch("/autofillers")
      .then(response => response.json())
      .then(data => {
        this.setState({
          autofillers: data
        });
        console.log(this.state.autofillers)
      });
  }

  addField(e) {
    var updatedFields = this.state.fields;
    updatedFields.push("");
    this.setState({
      fields: updatedFields
    });
  }

  removeField(e) {
    var updatedFields = this.state.fields;
    delete updatedFields[e.target.attributes["data-field-entry"].nodeValue];

    this.setState({
      fields: updatedFields
    });
  }

  changeAutofill(e) {
    this.setState({
      autofill: !this.state.autofill
    })

  }

  loadAutofillFields() {
    fetch("/autofillers/" + this.state.autofiller)
      .then(response => response.json())
      .then(data => {
        console.log("Data output is " + data);
        this.setState({
          autofill_fields: data
        });
        console.log(this.state)
      });
  }

  autofillFields(e) {
    console.log(e.target.selectedOptions[0].value + " selected.")
    this.setState({
      autofiller: e.target.selectedOptions[0].value
    }, this.loadAutofillFields);

  }

  updateAutofillMapping(e) {
    var field_index = e.target.attributes["data-autofill-field-index"].nodeValue;
    var updatedAutofillMapping = this.state.autofill_mapping;
    updatedAutofillMapping[field_index] = e.target.selectedOptions[0].value

    this.setState({
      autofill_mapping: updatedAutofillMapping
    });
  }

  render () {

    const autofillers = this.state.autofillers.map((autofiller, i) =>
      <option value={autofiller} key={i} >{autofiller}</option>
    );

    const autofill_options = this.state.autofill_fields.map((field, i) =>
      <option value={field} key={i}>{field}</option>
    );

    const inputs = this.state.fields.map((field, i) =>
      <div className="field_entry" key={i}>
        <input id={this.props.scope + "_field"} defaultValue={field} name={this.props.scope + "[fields][]"} />
        <button data-field-entry={i} type="button" onClick={this.removeField} className="action_button">Remove</button>
        {this.state.autofill &&
         <div className="autofill_info">
         <select className="autofillField" data-autofill-field-index={i} value={this.state.autofill_mapping[i]} onChange={this.updateAutofillMapping} name={this.props.scope + "[autofill_mapping][]"}>
            {autofill_options}
          </select>
         </div>
        }
      </div>
    );

    return (
      <React.Fragment>
        <label htmlFor={this.props.scope + "_field"}>Fields</label>
        {inputs}
        <button type="button" onClick={this.addField} className="action_button">Add Field</button>

        <br /><label htmlFor={this.props.scope + "_autofill"}>Autofill?</label>
        <input type="checkbox" onChange={this.changeAutofill} checked={this.state.autofill} name={this.props.scope + "[autofill]"} value="1"/>

        {this.state.autofill &&
         <div className="form_container">
          <label htmlFor="autofiller">Choose an autofiller:</label>
         <select className="autofiller" id="autofiller_choose" value={this.state.autofiller} onChange={this.autofillFields} name={this.props.scope + "[autofiller]"}>
            <option label=" "></option>
            {autofillers}
          </select>
         </div>
        }
      </React.Fragment>
    );
  }
}

SchemaCreation.propTypes = {
  fields: PropTypes.node,
  scope: PropTypes.node
};
export default SchemaCreation
