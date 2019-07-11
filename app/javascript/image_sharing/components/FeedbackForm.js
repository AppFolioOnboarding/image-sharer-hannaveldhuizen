import React from 'react';
import { Alert, Button, Form, Input, Label } from 'reactstrap';
import { post } from '../utils/helper';

export default class FeedbackForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      comments: '',
      alertMessage: '',
    };
  }

  onNameChange(name) {
    this.setState({ name });
  }

  onCommentsChange(comments) {
    this.setState({ comments });
  }

  onSubmit() {
    return post('/api/feedbacks', {
      name: this.state.name,
      comments: this.state.comments
    }).then((response) => {
      this.setState({ alertMessage: response.message });
    }).catch((response) => {
      this.setState({ alertMessage: response.data.message });
    }).finally(() => {
      this.setState({ name: '', comments: '' });
    });
  }

  alert() {
    if (this.state.alertMessage === 'success') {
      return (<Alert color="success">Feedback submitted successfully!</Alert>);
    }

    if (this.state.alertMessage === 'error') {
      return (<Alert color="danger">An error occurred.</Alert>);
    }

    return '';
  }


  render() {
    return (
      <Form style={{ width: 400 }}>
        {this.alert()}
        <Label for="name">Your name:</Label><br />
        <Input
          type="text"
          id="name"
          value={this.state.name}
          placeholder="Name"
          onChange={event => this.onNameChange(event.target.value)}
        />
        <br />
        <Label for="comment">Comments:</Label><br />
        <Input
          type="textarea"
          id="comment"
          value={this.state.comments}
          placeholder="Text"
          onChange={event => this.onCommentsChange(event.target.value)}
        />
        <br />
        <Button color="primary" onClick={() => this.onSubmit()}>Submit</Button>
      </Form>
    );
  }
}
