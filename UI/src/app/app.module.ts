import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';


import { AppComponent } from './app.component';
import { NavigationBarComponent } from './shared/components/navigation-bar/navigation-bar.component';
import { ByocHeaderComponent } from './byoc/components/byoc-header/byoc-header.component';
import { FooterComponent } from './core/components/footer/footer.component';
import { WorkspaceComponent } from './byoc/components/workspace/workspace.component';
import { ContainerListingComponent } from './byoc/components/container-listing/container-listing.component';

@NgModule({
  declarations: [
    AppComponent,
    NavigationBarComponent,
    ByocHeaderComponent,
    FooterComponent,
    WorkspaceComponent,
    ContainerListingComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
