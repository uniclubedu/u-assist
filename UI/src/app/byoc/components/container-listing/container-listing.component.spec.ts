import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContainerListingComponent } from './container-listing.component';

describe('ContainerListingComponent', () => {
  let component: ContainerListingComponent;
  let fixture: ComponentFixture<ContainerListingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ContainerListingComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ContainerListingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
