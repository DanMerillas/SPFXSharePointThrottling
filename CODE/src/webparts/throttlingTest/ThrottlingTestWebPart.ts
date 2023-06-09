import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Version } from '@microsoft/sp-core-library';
import { BaseClientSideWebPart } from '@microsoft/sp-webpart-base';
import ThrottlingTest from './components/ThrottlingTest';
import { IThrottlingTestProps } from './components/IThrottlingTestProps';

import { getSP } from '../../pnpConfig/pnpConfig';

export interface IThrottlingTestWebPartProps {
  description: string;
}

export default class ThrottlingTestWebPart extends BaseClientSideWebPart<IThrottlingTestWebPartProps> {



  public render(): void {
    const element: React.ReactElement<IThrottlingTestProps> = React.createElement(
      ThrottlingTest,
      {
      
      }
    );

    ReactDom.render(element, this.domElement);
  }

  protected async onInit(): Promise<void> {
    await super.onInit();
    
    getSP(this.context);
  }
 
  
  protected onDispose(): void {
    ReactDom.unmountComponentAtNode(this.domElement);
  }

  protected get dataVersion(): Version {
    return Version.parse('1.0');
  }

}
