import React from "react"
import PropTypes from "prop-types"
class Hello extends React.Component {
  render () {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
      </React.Fragment>
    );
  }
}

Hello.propTypes = {
  greeting: PropTypes.string
};
export default Hello
