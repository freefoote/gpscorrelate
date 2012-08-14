/* gui.h
 * Written by Daniel Foote.
 * Started Feb 2005.
 *
 * This file contains the function prototypes for the
 * stuff in gui.c */

/* Copyright 2005 Daniel Foote.
 *
 * This file is part of gpscorrelate.
 *
 * gpscorrelate is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * gpscorrelate is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with gpscorrelate; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

GtkWidget* CreateMatchWindow(void);
gboolean DestroyWindow(GtkWidget *Widget, GdkEvent *Event, gpointer Data);

void AddPhotosButtonPress( GtkWidget *Widget, gpointer Data );
void AddPhotoToList(char* Filename);
void RemovePhotosButtonPress( GtkWidget *Widget, gpointer Data );

void SetListItem(GtkTreeIter* Iter, char* Filename, char* Time, double Lat,
		double Long, double Elev, char* PassedState, int IncludesGPS);
void SetState(GtkTreeIter* Iter, char* State);

void SelectGPSButtonPress( GtkWidget *Widget, gpointer Data );
void CorrelateButtonPress( GtkWidget *Widget, gpointer Data );
void StripGPSButtonPress( GtkWidget *Widget, gpointer Data );

void GtkGUIUpdate(void);
