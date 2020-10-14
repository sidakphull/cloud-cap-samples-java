using { my.bookshop as my } from '../db/schema';
using { cuid, managed } from '@sap/cds/common';

service ChapterService {
	entity Chapters as projection on my.Chapters;
	entity Pages as projection on my.Pages;
}
