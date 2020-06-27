import React from "react"
import PropTypes from "prop-types"
class SchemaCreation extends React.Component {
  constructor(props) {
    super(props);
    if (!props.fields) {
      props.fields = [];
    }
    this.state = {
      fields: props.fields
    }
    this.addField = this.addField.bind(this);
    this.removeField = this.removeField.bind(this);
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

  render () {
    const inputs = this.state.fields.map((field, i) =>
      <div className="field_entry" key={i}>
        <input id={this.props.scope + "_field"} defaultValue={field} name={this.props.scope + "[fields][]"} />
        <button data-field-entry={i} type="button" onClick={this.removeField} className="action_button">Remove</button>
      </div>
    );
    return (
      <React.Fragment>
        <label for={this.props.scope + "_field"}>Fields</label>
        {inputs}
        <button type="button" onClick={this.addField} class="action_button">Add Field</button>
      </React.Fragment>
    );
  }
}

SchemaCreation.propTypes = {
  fields: PropTypes.node,
  scope: PropTypes.node
};
export default SchemaCreation
