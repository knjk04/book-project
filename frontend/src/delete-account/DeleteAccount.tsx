/*
The book project lets a user keep track of different books they would like to read, are currently
reading, have read or did not finish.
Copyright (C) 2021  Karan Kumar

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see <https://www.gnu.org/licenses/>.
*/

import React, {Component} from 'react'
import {Layout} from '../shared/components/Layout';
import {RouteComponentProps} from 'react-router-dom';
import Button from '@material-ui/core/Button';
import PasswordInput from '../shared/form/Password';
import HttpClient from '../shared/http/HttpClient';
import {Link} from 'react-router-dom';
import './DeleteAccount.css'

interface IDeleteAccountState {
    password: string,
    isPasswordDirty: boolean,
    isPasswordInvalid: boolean,
}

type IDeleteAccountProps = Record<string,unknown>& RouteComponentProps;

export default class DeleteAccount extends Component<IDeleteAccountProps, IDeleteAccountState>{
    constructor(props:IDeleteAccountProps) {
        super(props);

        this.state = {
            password: '',
            isPasswordDirty: false,
            isPasswordInvalid: false,
        }
        this.onPasswordChanged = this.onPasswordChanged.bind(this)
        this.onDeleteInvoked = this.onDeleteInvoked.bind(this)
    }

    onPasswordChanged(password: string): void {
        this.setState({
            password,
            isPasswordDirty: true,
            isPasswordInvalid: password === ''
        })
    }

    isPasswordInvalid(): boolean {
        const isPasswordDirtyAndBlank = this.state.password === '' && this.state.isPasswordDirty
        return isPasswordDirtyAndBlank || this.state.isPasswordInvalid
    }

    onDeleteInvoked():void {
        HttpClient.deleteAccount(this.state.password)
        .then(response => {
            if (response.ok) {
                this.props.history.push('/')
            } else {
                this.setState({isPasswordInvalid:true});
            }
        })
        .catch(error => {
            console.error('error: ', error);
        })
    }

    render():JSX.Element {
        return (
            <div>
                <Layout 
                    title="Delete Account" 
                    centered={true} 
                    showBackArrow={true}
                    >
                    <div className="delete-account-body">
                        <h2 className="delete-account-text">
                            Warning: this action is irreversible.
                        </h2>
                        <p className="delete-account-text">
                            If you&apos;d like to first export your data, please do so below. 
                            This gives you a chance to save your data in case you&apos;d ever 
                            like to create an account again!
                        </p>
                        <Button 
                            className="delete-account-page-input"
                            id="export-data-button"
                            variant="contained"
                            color="primary">
                            Export account data
                        </Button>
                        <p className="delete-account-text">
                        If you&apos;re sure you want to delete your account, 
                        confirm deletion by entering your password in the field below.
                        </p>
                        <PasswordInput
                            class={'delete-account-page-input'}
                            placeholderText="Confirm Password"
                            onPasswordChanged={this.onPasswordChanged}
                            isInvalid={this.isPasswordInvalid()}
                            errorMessage={'Incorrect password'}
                        />
                        <Button
                            className="delete-account-page-input"
                            id="delete-account-button"
                            variant="contained"
                            onClick={this.onDeleteInvoked}
                            color="secondary">
                            Delete my account
                        </Button>
                    </div>
                    <Link to="/settings" className="link-to-settings">
                        <Button
                            className="delete-account-page-input"
                            id="cancel-button"
                            variant="contained"
                            color="default">
                            Cancel
                        </Button>
                    </Link>
                </Layout>
            </div>
        )
    }
}

