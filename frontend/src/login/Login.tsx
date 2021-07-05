/*
The book project lets a user keep track of different books they would like to read, are currently
reading, have read or did not finish.
Copyright (C) 2020  Karan Kumar

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see <https://www.gnu.org/licenses/>.
*/

import React, {Component, ReactElement} from 'react';
import './Login.css';
import Button from '@material-ui/core/Button';
import Password from '../shared/form/Password';
import EmailAddress from '../shared/form/EmailAddress';
import {Link} from "react-router-dom";
import logo from '../shared/media/logo/logo_one_line@1x.png';
import HttpClient from '../shared/http/HttpClient';
import {RouteComponentProps} from 'react-router-dom';
import {MY_BOOKS, SIGN_UP} from "../shared/routes";
import ForgotPasswordModal from './forgotPassword/ForgotPasswordModal';
import PasswordResetModal from './forgotPassword/PasswordResetModal';

interface IState {
    email: string,
    password: string,
    isEmailDirty: boolean,
    isPasswordDirty: boolean,
    isEmailInvalid: boolean,
    isPasswordInvalid: boolean,
    loginFailed: boolean,
    showForgotPasswordModal: boolean,
    showPasswordResetModal: boolean
}

type LoginProps = Record<string, unknown> & RouteComponentProps
class Login extends Component<LoginProps, IState> {
    constructor(props: LoginProps) {
        super(props)

        this.state = {
            email: '',
            password: '',
            isEmailDirty: false,
            isPasswordDirty: false,
            isEmailInvalid: false,
            isPasswordInvalid: false,
            loginFailed: false,
            showForgotPasswordModal: false,
            showPasswordResetModal: false
        }

        this.onPasswordChanged = this.onPasswordChanged.bind(this)
        this.onForgotPassword = this.onForgotPassword.bind(this)
        this.onForgotPasswordModalClose = this.onForgotPasswordModalClose.bind(this)
        this.onPasswordResetClicked = this.onPasswordResetClicked.bind(this)
        this.onPasswordResetModalClose = this.onPasswordResetModalClose.bind(this)
        this.onEmailChanged = this.onEmailChanged.bind(this)
        this.onClickLogin = this.onClickLogin.bind(this)
        this.sendLoginRequest = this.sendLoginRequest.bind(this)
        this.sendLoginRequestIfCredentialsAreValid =
        this.sendLoginRequestIfCredentialsAreValid.bind(this)
    }

    onClickLogin(): void {
        this.setState({
            isEmailInvalid: this.state.email === '',
            isPasswordInvalid: this.state.password === ''
        }, this.sendLoginRequestIfCredentialsAreValid)
    }

    onEmailChanged(email: string): void {
        this.setState({
            email,
            isEmailDirty: true,
            isEmailInvalid: email === ''
        })
    }

    onPasswordChanged(password: string): void {
        this.setState({
            password,
            isPasswordDirty: true,
            isPasswordInvalid: password === ''
        })
    }
    
    onForgotPassword(): void {
        this.setState({
           showForgotPasswordModal: true
        })
    }
    
    onForgotPasswordModalClose(): void {
        this.setState({
            showForgotPasswordModal: false
        })
    }

    onPasswordResetClicked(): void {
        this.onForgotPasswordModalClose();
        this.setState({
           showPasswordResetModal: true
        })
    }
    
    onPasswordResetModalClose(): void {
        this.setState({
            showPasswordResetModal: false
        })
    }

    isEmailInvalid(): boolean {
        const isEmailDirtyAndBlank = this.state.email === '' && this.state.isEmailDirty
        return isEmailDirtyAndBlank || this.state.isEmailInvalid
    }

    isPasswordInvalid(): boolean {
        const isPasswordDirtyAndBlank = this.state.password === '' && this.state.isPasswordDirty
        return isPasswordDirtyAndBlank || this.state.isPasswordInvalid
    }

    sendLoginRequestIfCredentialsAreValid(): void {
        if (!this.state.isEmailInvalid && !this.state.isPasswordInvalid) {
            this.sendLoginRequest()
        }
    }

    sendLoginRequest(): void {
        HttpClient.login(this.state.email, this.state.password)
            .then(response => {
                if (response.ok) {
                    this.props.history.push(MY_BOOKS)
                } else {
                    this.setState({loginFailed: true});
                }
            })
            .catch(error => {
                this.setState({loginFailed: true})
                console.error('error: ', error)
            })
    }

    renderLoginError(): ReactElement {
        return (
               <p className="error-message">
                 Your email or password is incorrect. Please try again
               </p>
        )
    }  

    render(): ReactElement {
        return (
            <div className="center-table">
                <div className="center-table-cell">
                    <img src={logo} alt="Logo" className="center" />

                    <br />
                    <br />
                    <br />

                    <div className="center">
                        <EmailAddress
                            class={'center login'}
                            classHelper={'center helper'}
                            isInvalid={this.isEmailInvalid()}
                            onChange={this.onEmailChanged}
                            errorMessage={'Please enter an email address'}
                        />

                        <br />

                        <Password
                            placeholderText={'Password'}
                            class={'center login'}
                            classHelper={'center helper'}
                            onPasswordChanged={this.onPasswordChanged}
                            isInvalid={this.isPasswordInvalid()}
                            errorMessage={'Please enter a password'}
                        />

                        <br />
                        <br />

                        <Button
                            className="center login"
                            variant="contained"
                            color="primary"
                            onClick={this.onClickLogin}>
                            Log in
                        </Button>

                        <br />
                        <br />

                        <Button
                            className="center login"
                            id="createAccount"
                            component={Link}
                            to={SIGN_UP}>
                            Create account
                        </Button>
                        <Button className="center login" onClick={this.onForgotPassword}>
                            Forgot Password
                        </Button>

                        {this.state.loginFailed && this.renderLoginError()}

                    </div>
                </div>
                <ForgotPasswordModal 
                    open={this.state.showForgotPasswordModal} 
                    onClose={this.onForgotPasswordModalClose}
                    onPasswordResetClicked={this.onPasswordResetClicked}
                />
                <PasswordResetModal
                    open={this.state.showPasswordResetModal} 
                    onClose={this.onPasswordResetModalClose}
                />
            </div>
        )
    }
}

export default Login;
