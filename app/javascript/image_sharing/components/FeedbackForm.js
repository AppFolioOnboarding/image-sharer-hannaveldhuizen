import React from 'react';
import { Button, Form, Input, Label } from 'reactstrap';

export default function FeedbackForm() {
  return (
    <Form style={{ width: 400 }}>
      <Label for="name">Your name:</Label><br />
      <Input type="text" id="name" />
      <br />
      <Label for="comment">Comments:</Label><br />
      <Input type="textarea" id="comment" />
      <br />
      <Button color="primary">Submit</Button>
    </Form>
  );
}
